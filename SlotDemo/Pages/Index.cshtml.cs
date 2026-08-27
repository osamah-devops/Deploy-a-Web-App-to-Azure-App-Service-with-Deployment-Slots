using Microsoft.AspNetCore.Mvc.RazorPages;

public class IndexModel : PageModel
{
    public string SlotName =>
        Environment.GetEnvironmentVariable("SLOT_NAME") ?? "unknown";
    public string Color =>
        Environment.GetEnvironmentVariable("SLOT_COLOR") ?? "#cccccc";

    public void OnGet() { }
}
