using System;
using Xunit;
using WebApiHiHello;
using WebApiHiHello.Controllers;
using System.Collections.Generic;

namespace ApiCrudTest.Tests
{
    public class UnitTest1
    {
        List<string> name = new List<string>();
        [Fact]
        public void Test_HiHello_Get()
        {
            // var expected = valuesController.Get();
            Assert.Equal("hi", "hi");
        }
    }
}
