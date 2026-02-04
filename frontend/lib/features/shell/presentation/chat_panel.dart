import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../dashboard/domain/entities/ui_node.dart';
import '../../dashboard/dashboard_controller.dart';




class ChatPanel extends StatefulWidget {
  final DashboardController dashboardController;

  const ChatPanel({
    super.key,
    required this.dashboardController,
  });




  @override
  State<ChatPanel> createState() => _ChatPanelState();
}



class _ChatPanelState extends State<ChatPanel> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _messages = [];

  bool _sending = false;

  Future<void> _send() async {
    final text = _controller.text.trim();
    if (text.isEmpty || _sending) return;

    setState(() {
      _messages.add('🧑 $text');
      _sending = true;
      _controller.clear();
    });

    try {
      final response = await http.post(
        Uri.parse('http://localhost:5080/api/chat'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'prompt': text}),
      );

         final decoded = jsonDecode(response.body);

        // 1️⃣ mensaje de chat
        final chatMessage = decoded['chat']?['message'];
        if (chatMessage != null) {
          setState(() {
            _messages.add('🤖 $chatMessage');
          });

          // dashboard
          final uiJson = decoded['ui']?['layout'];
          if (uiJson != null) {
            final uiLayout = UiNode.fromJson(uiJson);
            widget.dashboardController.setLayout(uiLayout);
          }

        }

        // 2️⃣ layout de UI (si existe)
        final uiJson = decoded['ui']?['layout'];
        if (uiJson != null) {
          final uiLayout = UiNode.fromJson(uiJson);
          widget.dashboardController.setLayout(uiLayout);
        }



    } catch (e) {
      setState(() {
        _messages.add('⚠️ Error de conexión');
      });
    } finally {
      setState(() => _sending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade50,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            alignment: Alignment.centerLeft,
            child: const Text(
              'Asistente',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: _messages.length,
              itemBuilder: (_, i) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(_messages[i]),
              ),
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    onSubmitted: (_) => _send(),
                    decoration: const InputDecoration(
                      hintText: 'Escribí una consulta...',
                      isDense: true,
                    ),
                  ),
                ),
                IconButton(
                  icon: _sending
                      ? const CircularProgressIndicator()
                      : const Icon(Icons.send),
                  onPressed: _sending ? null : _send,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
