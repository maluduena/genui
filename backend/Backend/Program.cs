using System.Text.Json;
using System.Net.Http.Json;

var builder = WebApplication.CreateBuilder(args);

// CORS (por si luego usás web)
builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowAll", p =>
        p.AllowAnyOrigin()
         .AllowAnyHeader()
         .AllowAnyMethod());
});

var app = builder.Build();
app.UseCors("AllowAll");

app.MapPost("/api/chat", async (ChatRequest request, IConfiguration config) =>
{
    var apiKey = config["Gemini:ApiKey"];
    var modelUrl = config["Gemini:ModelUrl"];

    using var client = new HttpClient();

 var prompt =
    "Respondé SOLO un JSON válido. No expliques nada.\n" +
    "Formato exacto:\n" +
    "{\n" +
    "  \"message\": \"texto corto para el chat\",\n" +
    "  \"ui\": {\n" +
    "    \"type\": \"card\",\n" +
    "    \"data\": {\n" +
    "      \"title\": \"...\",\n" +
    "      \"subtitle\": \"...\"\n" +
    "    }\n" +
    "  }\n" +
    "}\n\n" +
    "Usuario dice: " + request.Prompt;


    var payload = new
    {
        contents = new[]
        {
            new {
                parts = new[]
                {
                    new { text = prompt }
                }
            }
        }
    };

    var response = await client.PostAsJsonAsync(
        $"{modelUrl}?key={apiKey}",
        payload
    );

    var raw = await response.Content.ReadAsStringAsync();

    if (!response.IsSuccessStatusCode)
    {
        return Results.Ok(new
        {
            message = "Error al consultar Gemini",
            ui = new
            {
                type = "card",
                data = new
                {
                    title = "Error",
                    subtitle = "Gemini no respondió correctamente"
                }
            }
        });
    }

    using var doc = JsonDocument.Parse(raw);

    var text = doc.RootElement
        .GetProperty("candidates")[0]
        .GetProperty("content")
        .GetProperty("parts")[0]
        .GetProperty("text")
        .GetString() ?? "";

    // Limpieza por si Gemini mete ```json
    var start = text.IndexOf('{');
    var end = text.LastIndexOf('}');
    if (start >= 0 && end > start)
    {
        text = text.Substring(start, end - start + 1);
    }

    return Results.Content(text, "application/json");
});


app.Run("http://localhost:5080");

public record ChatRequest(string Prompt);
