using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;

namespace WebApiHiHello.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ValuesController : ControllerBase
    {
        public static List<string> name=new List<string>()
        {
            "raj","ravi"
        };
        
        // GET api/values
        [HttpGet]
        public List<string> Get()
        {
            return name;
        }

        // GET api/values/5
        [HttpGet("{greet}")]
        public ActionResult<string> Get(string greet)
        {
            if (greet == "hi")
                return "hello";
            else if(greet == "hello")
                return "hi";
            return "good day";
        }

        // POST api/values
        [HttpPost]
        public void Post([FromBody] string value)
        {
            name.Add(value);
        }

        // PUT api/values/5
        [HttpPut("{id}")]
        public void Put(int id, [FromBody] string value)
        {
            name[id] = value;
        }

        // DELETE api/values/5
        [HttpDelete("{id}")]
        public void Delete(int id)
        {
            name.RemoveAt(id);
        }
    }
}
