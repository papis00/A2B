from django.shortcuts import render
from rest_framework.decorators import api_view
from rest_framework.response import Response
from .deployment.deployment_manager import DeploymentManager
from .models import CommandVariant, Constructor
from django.shortcuts import get_object_or_404
from rest_framework import viewsets
from .serializers import ConstructorSerializer



class ConstructorViewSet(viewsets.ModelViewSet):
    serializer_class = ConstructorSerializer
    queryset = Constructor.objects.all()

@api_view(['POST'])
def translate_command(request):
    # 1. Récupérer les données de la requête
    source_command = request.data.get('command', '').strip()
    target_constructor_id = request.data.get('constructor_id')
    
    if not source_command or not target_constructor_id:
        return Response({'error': 'Missing command or constructor_id'}, status=400)

    try:
        # 2. Trouver le constructeur cible
        target_constructor = get_object_or_404(Constructor, pk=target_constructor_id)
        
        # 3. Trouver la variante de commande correspondante
        # (Implémentez votre logique de correspondance ici)
        matching_variant = CommandVariant.objects.filter(
            command_text__icontains=source_command
        ).first()
        
        if not matching_variant:
            return Response({'error': 'Command not found'}, status=404)
            
        # 4. Trouver la variante équivalente pour le constructeur cible
        translated_variant = CommandVariant.objects.filter(
            action=matching_variant.action,
            constructor=target_constructor
        ).first()
        
        if not translated_variant:
            return Response({'error': 'No translation available'}, status=404)
            
        # 5. Retourner la réponse
        return Response({
            'original_command': source_command,
            'translated_command': translated_variant.command_text,
            'constructor': target_constructor.name,
            'notes': translated_variant.notes
        })
        
    except Exception as e:
        return Response({'error': str(e)}, status=500)


@api_view(['POST'])
def deploy_commands(request):
    try:
        device_info = request.data.get('device')
        if not device_info:
            return Response({'error': 'Les informations du périphérique sont manquantes'}, status=400)

        commands = device_info.pop('commands', [])
        if not commands:
            return Response({'error': 'Aucune commande à déployer'}, status=400)

        deployment_manager = DeploymentManager()
        result = deployment_manager.deploy_commands(
            device_info=device_info,
            commands=device_info.get('commands', [])
        )

        if result['success']:
            return Response({
                'success': True,
                'message': 'le déploiement a réussi',
                'log_id': result['log_id']
            })
        else:
            return Response({
                'success': False,
                'error': result.get('error', 'le déploiement a échoué'),
            }, status=400)

    except Exception as e:
        return Response({
            'success': False,
            'error': str(e)
        }, status=500)