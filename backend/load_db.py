from django.core.management.base import BaseCommand
from commandes.db import run

class Command(BaseCommand):
    help = 'Charge les données initiales des commandes réseau dans la base de données'

    
    def handle(self, *args, **kwargs):
        try:
            self.stdout.write('Début du chargement des données...')
            
           
            run()
            
            self.stdout.write(self.style.SUCCESS('Données chargées avec succès !'))
            
        except Exception as e:
            self.stdout.write(
                self.style.ERROR(f'Erreur lors du chargement des données : {str(e)}')
            )