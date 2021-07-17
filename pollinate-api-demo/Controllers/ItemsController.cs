﻿using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace pollinate_api_demo.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ItemsController : ControllerBase
    {
        private readonly ICosmosDbService _cosmosDbService;

        public ItemsController(ICosmosDbService cosmosDbService)
        {
            _cosmosDbService = cosmosDbService ?? throw new ArgumentNullException(nameof(cosmosDbService));
        }

        // GET api/items
        [HttpGet]
        public async Task<IActionResult> List()
        {
            return Ok(await _cosmosDbService.GetMultipleAsync("SELECT * FROM c"));
        }

        // GET api/items/5
        [HttpGet("{id}")]
        public async Task<IActionResult> Get(string id)
        {
            return Ok(await _cosmosDbService.GetAsync(id));
        }

        // POST api/items
        [HttpPost]
        public async Task<IActionResult> Create([FromBody] Item item)
        {
            item.id = Guid.NewGuid().ToString();
            await _cosmosDbService.AddAsync(item);
            return CreatedAtAction(nameof(Get), new { id = item.id }, item);
        }

        // PUT api/items/5
        [HttpPut("{id}")]
        public async Task<IActionResult> Edit([FromBody] Item item)
        {
            await _cosmosDbService.UpdateAsync(item.id, item);
            return NoContent();
        }

        // DELETE api/items/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> Delete(string id)
        {
            await _cosmosDbService.DeleteAsync(id);
            return NoContent();
        }
    }
}

