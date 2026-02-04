import 'package:flutter/material.dart';
import '../../core/state/ui_state.dart';
import '../../core/ui_dsl/node.dart';
import '../../core/ui_dsl/layout_node.dart';
import '../../core/ui_dsl/widget_node.dart';

class ChatPanel extends StatefulWidget {
  final UIState uiState;
  
  const ChatPanel({required this.uiState, super.key});

  @override
  State<ChatPanel> createState() => _ChatPanelState();
}

class _ChatPanelState extends State<ChatPanel> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _messages = ["AI: Hola! Dime qué UI quieres ver."];

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add("User: $text");
      _controller.clear();
    });

    // Mock AI response for now
    Future.delayed(const Duration(seconds: 1), () {
      _processCommand(text);
    });
  }

  void _processCommand(String text) {
    String response = "Entendido, actualizando UI...";
    
    // Simple command parsing for demo
    if (text.toLowerCase().contains("grid")) {
      widget.uiState.updateUI(
        LayoutNode(
          type: 'vertical',
          children: [
             WidgetNode(type: 'kpi', data: {'title': 'Total Sales', 'value': '\$50M'}),
             LayoutNode(
                type: 'grid',
                props: {'columns': 2},
                children: [
                  WidgetNode(type: 'kpi', data: {'title': 'A', 'value': '100'}),
                  WidgetNode(type: 'kpi', data: {'title': 'B', 'value': '200'}),
                  WidgetNode(type: 'kpi', data: {'title': 'C', 'value': '300'}),
                  WidgetNode(type: 'kpi', data: {'title': 'D', 'value': '400'}),
                ]
             )
          ]
        )
      );
    } else if (text.toLowerCase().contains("chart") || text.toLowerCase().contains("grafico")) {
       widget.uiState.updateUI(
         LayoutNode(
           type: 'vertical',
           children: [
             WidgetNode(type: 'lineChart', data: {'title': 'Realtime Data'}),
           ]
         )
       );
    } else {
      response = "No entendí ese comando. Prueba 'mostrar grid' o 'ver grafico'.";
    }

    setState(() {
      _messages.add("AI: $response");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(left: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.blue.shade50,
            width: double.infinity,
            child: const Text("GenUI Assistant", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                final isUser = msg.startsWith("User:");
                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isUser ? Colors.blue.shade100 : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(msg.replaceAll("User: ", "").replaceAll("AI: ", "")),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: "Describe la UI...",
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
