from django.db import models

# Create your models here.

class Constructor(models.Model):
    name = models.CharField(max_length=100, unique=True)
    description = models.TextField(blank=True, null=True)

    def __str__(self):
        return self.name

    class Meta:
        verbose_name = "Constructor"
        verbose_name_plural = "Constructors"
        indexes = [
            models.Index(fields=["name"]),
        ]

class CommandAction(models.Model):
    CATEGORY_CHOICES = [
        ("routing", "Routing"),
        ("switching", "Switching"),
        ("security", "Security"),
        ("management", "Management"),
        ("other", "Other"),
    ]

    title = models.CharField(max_length=255)
    category = models.CharField(max_length=50, choices=CATEGORY_CHOICES)
    description = models.TextField()

    def __str__(self):
        return self.title

    class Meta:
        verbose_name = "Command Action"
        verbose_name_plural = "Command Actions"
        indexes = [
            models.Index(fields=["category", "title"]),
        ]

class CommandVariant(models.Model):
    action = models.ForeignKey(
        CommandAction, on_delete=models.CASCADE, related_name="variants"
    )
    constructor = models.ForeignKey(
        Constructor, on_delete=models.CASCADE, related_name="commands"
    )
    command_text = models.TextField()
    example = models.TextField(blank=True, null=True)
    notes = models.TextField(blank=True, null=True)

    def __str__(self):
        return f"{self.constructor.name} - {self.command_text[:50]}"

    class Meta:
        verbose_name = "Command Variant"
        verbose_name_plural = "Command Variants"
        unique_together = ["action", "constructor"]
        indexes = [
            models.Index(fields=["action", "constructor"]),
        ]

class CommandAlias(models.Model):
    constructor = models.ForeignKey(
        Constructor, on_delete=models.CASCADE, related_name="aliases"
    )
    alias_text = models.CharField(max_length=255)
    full_command = models.CharField(max_length=255)

    def __str__(self):
        return f"{self.alias_text} → {self.full_command}"

    class Meta:
        verbose_name = "Command Alias"
        verbose_name_plural = "Command Aliases"
        unique_together = ["constructor", "alias_text"]
        indexes = [
            models.Index(fields=["constructor", "alias_text"]),
        ]

class CommandParameter(models.Model):
    name = models.CharField(max_length=100, unique=True)
    description = models.TextField()
    validation_regex = models.TextField(blank=True, null=True)

    def __str__(self):
        return self.name

    class Meta:
        verbose_name = "Command Parameter"
        verbose_name_plural = "Command Parameters"
        indexes = [
            models.Index(fields=["name"]),
        ]

class DeploymentLog(models.Model):
    device_ip = models.CharField(max_length=255)
    timestamp = models.DateTimeField(auto_now_add=True)
    status = models.CharField(max_length=50)
    commands = models.JSONField()
    output = models.TextField(blank=True)
    error = models.TextField(blank=True)

    class Meta:
        ordering = ['-timestamp']