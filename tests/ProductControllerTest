using Xunit;
using Moq;
using Microsoft.ApplicationInsights;
using Microsoft.Extensions.Logging;
using QuickShop.Controllers;

namespace QuickShop.Tests;

public class ProductControllerTests
{
    private readonly Mock<TelemetryClient> _mockTelemetryClient;
    private readonly Mock<ILogger<ProductController>> _mockLogger;
    private readonly ProductController _controller;

    public ProductControllerTests()
    {
        _mockTelemetryClient = new Mock<TelemetryClient>();
        _mockLogger = new Mock<ILogger<ProductController>>();
        _controller = new ProductController(_mockTelemetryClient.Object, _mockLogger.Object);
    }

    [Fact]
    public void GetAll_ReturnsAllProducts()
    {
        // Act
        var result = _controller.GetAll();

        // Assert
        Assert.NotNull(result);
        var okResult = Assert.IsType<OkObjectResult>(result.Result);
        var returnedProducts = Assert.IsAssignableFrom<IEnumerable<Product>>(okResult.Value);
        Assert.NotEmpty(returnedProducts);
    }

    [Fact]
    public void GetById_WithValidId_ReturnsProduct()
    {
        // Act
        var result = _controller.GetById(1);

        // Assert
        Assert.NotNull(result);
        var okResult = Assert.IsType<OkObjectResult>(result.Result);
        var product = Assert.IsType<Product>(okResult.Value);
        Assert.Equal(1, product.Id);
    }

    [Fact]
    public void GetById_WithInvalidId_ReturnsNotFound()
    {
        // Act
        var result = _controller.GetById(999);

        // Assert
        Assert.IsType<NotFoundResult>(result.Result);
        _mockTelemetryClient.Verify(t => t.TrackEvent(It.IsAny<string>(), It.IsAny<Dictionary<string, string>>(), It.IsAny<Dictionary<string, double>>()), Times.Once);
    }

    [Fact]
    public void Create_WithValidProduct_ReturnsCreatedAtAction()
    {
        // Arrange
        var request = new CreateProductRequest { Name = "Test Product", Price = 49.99m, Category = "Test" };

        // Act
        var result = _controller.Create(request);

        // Assert
        Assert.NotNull(result);
        var createdResult = Assert.IsType<CreatedAtActionResult>(result.Result);
        Assert.Equal(nameof(ProductController.GetById), createdResult.ActionName);
        _mockTelemetryClient.Verify(t => t.TrackEvent(It.IsAny<string>(), It.IsAny<Dictionary<string, string>>()), Times.Once);
    }

    [Fact]
    public void Create_WithInvalidProduct_ReturnsBadRequest()
    {
        // Arrange
        var request = new CreateProductRequest { Name = "", Price = -10 };

        // Act
        var result = _controller.Create(request);

        // Assert
        Assert.IsType<BadRequestObjectResult>(result.Result);
    }
}
