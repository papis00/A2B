import os
import sys
import yaml
import subprocess
from django.conf import settings
from ..models import DeploymentLog

class DeploymentManager:
    def __init__(self):
        self.ansible_dir = os.path.join(settings.BASE_DIR, 'ansible')
        self.inventory_dir = os.path.join(self.ansible_dir, 'inventory')
        self.playbook_dir = os.path.join(self.ansible_dir, 'playbooks')
        os.makedirs(self.inventory_dir, exist_ok=True)
        os.makedirs(self.playbook_dir, exist_ok=True)
        self.setup_windows_env()

    def setup_windows_env(self):
        """Configuration pour exécution sur Windows"""
        os.environ['PYTHONLEGACYWINDOWSSTDIO'] = '1'
        os.environ['ANSIBLE_SHELL_TYPE'] = 'powershell'
        os.environ['ANSIBLE_CONFIG'] = os.path.join(self.ansible_dir, 'ansible.cfg')

    def create_inventory(self, device_info):
        """Créer un inventaire Ansible avec les bonnes variables"""
        inventory_content = f"""[network_devices]
{device_info['ip']} ansible_user={device_info['username']} ansible_password={device_info['password']} ansible_connection=network_cli ansible_network_os=cisco.ios.ios
"""
        inventory_path = os.path.join(self.inventory_dir, 'hosts.ini')
        with open(inventory_path, 'w') as f:
            f.write(inventory_content)
        return inventory_path

    def create_playbook(self, commands):
        """Créer un playbook Ansible YAML"""
        playbook = [{
            'name': 'Deploy Network Commands',
            'hosts': 'network_devices',
            'gather_facts': False,
            'connection': 'network_cli',
            'tasks': [{
                'name': 'Run Cisco commands',
                'cisco.ios.ios_command': {
                    'commands': commands
                }
            }]
        }]
        playbook_path = os.path.join(self.playbook_dir, 'deploy_commands.yml')
        with open(playbook_path, 'w') as f:
            yaml.dump(playbook, f, sort_keys=False)
        return playbook_path

    def deploy_commands(self, device_info, commands):
        try:
            inventory_path = self.create_inventory(device_info)
            playbook_path = self.create_playbook(commands)

            process = subprocess.run([
                'ansible-playbook',
                '-i', inventory_path,
                playbook_path,
                '--extra-vars', f'ansible_python_interpreter={sys.executable}'
            ], capture_output=True, text=True)

            log = DeploymentLog.objects.create(
                device_ip=device_info['ip'],
                status='success' if process.returncode == 0 else 'failed',
                commands=commands,
                output=process.stdout,
                error=process.stderr
            )

            return {
                'success': process.returncode == 0,
                'log_id': log.id,
                'output': process.stdout if process.returncode == 0 else process.stderr
            }

        except Exception as e:
            return {'success': False, 'error': str(e)}


# class DeploymentManager:
    def __init__(self):
        self.ansible_dir = os.path.join(settings.BASE_DIR, 'ansible')
        os.makedirs(self.ansible_dir, exist_ok=True)
        self.setup_windows_env()

    def setup_windows_env(self):
        """Configuration de l'environnement Windows pour Ansible (A revoir au cas ou)"""
        os.environ['PYTHONLEGACYWINDOWSSTDIO'] = '1'
        os.environ['ANSIBLE_SHELL_TYPE'] = 'powershell'
        os.environ['ANSIBLE_CONFIG'] = os.path.join(self.ansible_dir, 'ansible.cfg')

    def create_inventory(self, device_info):
        """Creation d'un fichier d'inventaire Ansible"""
        inventory_content = f"""[network_devices]
{device_info['ip']} ansible_user={device_info['username']} ansible_password={device_info['password']} ansible_port={device_info.get('port', 22)}
"""
        inventory_path = os.path.join(self.ansible_dir, 'inventory', 'hosts.ini')
        os.makedirs(os.path.dirname(inventory_path), exist_ok=True)
        
        with open(inventory_path, 'w') as f:
            f.write(inventory_content)
        return inventory_path

    def deploy_commands(self, device_info, commands):
        try:
            inventory_path = self.create_inventory(device_info)
            playbook_path = os.path.join(self.ansible_dir, 'playbooks', 'deploy_commands.yml')

            os.makedirs(os.path.dirname(playbook_path), exist_ok=True)

            # Creation du playbook
            playbook = {
                'name': 'Deploy Network Commands',
                'hosts': 'network_devices',
                'gather_facts': False,
                'tasks': [{
                    'name': f'Execute command: {cmd}',
                    'raw': cmd,
                    'register': 'command_output'
                } for cmd in commands]
            }

            # ecrire le playbook dans un fichier
            with open(playbook_path, 'w') as f:
                json.dump([playbook], f, indent=2)

            # executer le playbook
            process = subprocess.run([
                'ansible-playbook',
                '-i', inventory_path,
                playbook_path,
                '--extra-vars', f'ansible_python_interpreter={sys.executable}'
            ], capture_output=True, text=True)

            # Creation du log de déploiement
            log = DeploymentLog.objects.create(
                device_ip=device_info['ip'],
                status='success' if process.returncode == 0 else 'failed',
                commands=commands,
                output=process.stdout,
                error=process.stderr
            )

            return {
                'success': process.returncode == 0,
                'log_id': log.id,
                'output': process.stdout if process.returncode == 0 else process.stderr
            }

        except Exception as e:
            return {'success': False, 'error': str(e)}