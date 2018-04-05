using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Newtonsoft.Json;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;

namespace frontend.Pages
{
    public class IndexModel : PageModel
    {
        [BindProperty]
        public Medewerker Medewerker { get; set; }

        private const string WebHookEndpoint = "https://s2events.azure-automation.net/webhooks?token=<not in source control>";

        public void OnGet()
        {

        }

        public async Task OnPostAsync()
        {
            var request = new HttpRequestMessage(HttpMethod.Post, WebHookEndpoint);
            request.Content = new StringContent(JsonConvert.SerializeObject(Medewerker), Encoding.UTF8, "application/json");

            var client = new HttpClient();
            await client.SendAsync(request);
        }
    }

    public class Medewerker
    {
        public string Voornaam {get ;set ;}
        public string Achternaam {get ;set ;}
        public string Email {get ;set ;}
        public string Telefoon {get ;set ;}
    }
}
