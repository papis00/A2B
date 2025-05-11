# les serializers sont pour exposer les modèles (Constructor, CommandAction, etc.)

#les serializers Convertissent les objets Django en JSON. Les relations (constructor, action) sont incluses en lecture seule pour fournir des données complètes.

from rest_framework import serializers
from .models import Constructor, CommandAction, CommandVariant, CommandAlias, CommandParameter

class ConstructorSerializer(serializers.ModelSerializer):
    class Meta:
        model = Constructor
        fields = ['id', 'name', 'description']

class CommandActionSerializer(serializers.ModelSerializer):
    class Meta:
        model = CommandAction
        fields = ['id', 'title', 'category', 'description']

class CommandVariantSerializer(serializers.ModelSerializer):
    constructor = ConstructorSerializer(read_only=True)
    action = CommandActionSerializer(read_only=True)

    class Meta:
        model = CommandVariant
        fields = ['id', 'action', 'constructor', 'command_text', 'example', 'notes']

class CommandAliasSerializer(serializers.ModelSerializer):
    constructor = ConstructorSerializer(read_only=True)

    class Meta:
        model = CommandAlias
        fields = ['id', 'constructor', 'alias_text', 'full_command']

class CommandParameterSerializer(serializers.ModelSerializer):
    class Meta:
        model = CommandParameter
        fields = ['id', 'name', 'description', 'validation_regex']