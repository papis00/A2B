# --*- coding: utf-8 -*-

from commandes.models import *

def run():
    Constructor.objects.get_or_create(
        name="Cisco",
        defaults={
            "description": "Leader en équipements réseau, utilise IOS et NX-OS."
        }
    )
    Constructor.objects.get_or_create(
        name="Huawei",
        defaults={
            "description": "Fournisseur chinois, utilise VRP (Versatile Routing Platform)."
        }
    )
    Constructor.objects.get_or_create(
        name="Juniper",
        defaults={
            "description": "Utilise Junos OS, populaire pour routeurs et commutateurs."
        }
    )
    Constructor.objects.get_or_create(
        name="MikroTik",
        defaults={
            "description": "Solutions abordables, utilise RouterOS."
        }
    )
    Constructor.objects.get_or_create(
        name="Fortinet",
        defaults={
            "description": "Spécialisé en sécurité, utilise FortiOS."
        }
    )

    # --- Table CommandAction ---
    # Création de 9 actions (3 routing, 3 switching, 3 sécurité)
    CommandAction.objects.get_or_create(
        title="Afficher la table de routage",
        defaults={
            "category": "routing",
            "description": "Affiche les routes actives dans la table de routage du dispositif."
        }
    )
    CommandAction.objects.get_or_create(
        title="Configurer une route statique",
        defaults={
            "category": "routing",
            "description": "Ajoute une route statique pour diriger le trafic vers une destination."
        }
    )
    CommandAction.objects.get_or_create(
        title="Vérifier l'état des voisins BGP",
        defaults={
            "category": "routing",
            "description": "Affiche l'état des sessions BGP avec les voisins configurés."
        }
    )
    CommandAction.objects.get_or_create(
        title="Afficher la table MAC",
        defaults={
            "category": "switching",
            "description": "Liste les adresses MAC apprises sur les ports du commutateur."
        }
    )
    CommandAction.objects.get_or_create(
        title="Configurer un VLAN",
        defaults={
            "category": "switching",
            "description": "Crée ou configure un VLAN pour segmenter le réseau."
        }
    )
    CommandAction.objects.get_or_create(
        title="Vérifier l'état d'une interface",
        defaults={
            "category": "switching",
            "description": "Affiche les détails (état, vitesse, erreurs) d'une interface."
        }
    )
    CommandAction.objects.get_or_create(
        title="Afficher les règles de pare-feu",
        defaults={
            "category": "security",
            "description": "Liste les règles de filtrage appliquées pour sécuriser le trafic."
        }
    )
    CommandAction.objects.get_or_create(
        title="Configurer une liste de contrôle d'accès",
        defaults={
            "category": "security",
            "description": "Ajoute une ACL pour filtrer le trafic entrant ou sortant."
        }
    )
    CommandAction.objects.get_or_create(
        title="Vérifier les sessions VPN",
        defaults={
            "category": "security",
            "description": "Affiche les sessions VPN actives (IPsec, SSL, etc.)."
        }
    )

    # --- Table CommandVariant ---
    # Création des variantes pour chaque action et chaque constructeur
    # On récupère les objets pour les lier
    cisco = Constructor.objects.get(name="Cisco")
    huawei = Constructor.objects.get(name="Huawei")
    juniper = Constructor.objects.get(name="Juniper")
    mikrotik = Constructor.objects.get(name="MikroTik")
    fortinet = Constructor.objects.get(name="Fortinet")

    # Action 1 : Afficher la table de routage
    action1 = CommandAction.objects.get(title="Afficher la table de routage")
    CommandVariant.objects.get_or_create(
        action=action1,
        constructor=cisco,
        defaults={
            "command_text": "show ip route",
            "example": "show ip route",
            "notes": "Affiche toutes les routes, y compris statiques et dynamiques."
        }
    )
    CommandVariant.objects.get_or_create(
        action=action1,
        constructor=huawei,
        defaults={
            "command_text": "display ip routing-table",
            "example": "display ip routing-table",
            "notes": "Utilisez 'detail' pour plus d'informations."
        }
    )
    CommandVariant.objects.get_or_create(
        action=action1,
        constructor=juniper,
        defaults={
            "command_text": "show route",
            "example": "show route",
            "notes": "Ajoutez 'detail' pour des informations supplémentaires."
        }
    )
    CommandVariant.objects.get_or_create(
        action=action1,
        constructor=mikrotik,
        defaults={
            "command_text": "ip route print",
            "example": "ip route print",
            "notes": "Affiche les routes avec leur état (active, disabled)."
        }
    )
    CommandVariant.objects.get_or_create(
        action=action1,
        constructor=fortinet,
        defaults={
            "command_text": "get router info routing-table all",
            "example": "get router info routing-table all",
            "notes": "Inclut toutes les routes, y compris BGP et OSPF."
        }
    )

    # Action 2 : Configurer une route statique
    action2 = CommandAction.objects.get(title="Configurer une route statique")
    CommandVariant.objects.get_or_create(
        action=action2,
        constructor=cisco,
        defaults={
            "command_text": "ip route {destination} {mask} {next_hop}",
            "example": "ip route 10.0.0.0 255.255.255.0 192.168.1.1",
            "notes": "Utilisez 'permanent' pour persister après un redémarrage."
        }
    )
    CommandVariant.objects.get_or_create(
        action=action2,
        constructor=huawei,
        defaults={
            "command_text": "ip route-static {destination} {mask} {next_hop}",
            "example": "ip route-static 10.0.0.0 255.255.255.0 192.168.1.1",
            "notes": "Vérifiez la VRF si utilisée."
        }
    )
    CommandVariant.objects.get_or_create(
        action=action2,
        constructor=juniper,
        defaults={
            "command_text": "set routing-options static route {destination}/{prefix_length} next-hop {next_hop}",
            "example": "set routing-options static route 10.0.0.0/24 next-hop 192.168.1.1",
            "notes": "Utilisez 'commit' pour appliquer."
        }
    )
    CommandVariant.objects.get_or_create(
        action=action2,
        constructor=mikrotik,
        defaults={
            "command_text": "ip route add dst-address={destination}/{prefix_length} gateway={next_hop}",
            "example": "ip route add dst-address=10.0.0.0/24 gateway=192.168.1.1",
            "notes": "Ajoutez 'comment' pour documenter."
        }
    )
    CommandVariant.objects.get_or_create(
        action=action2,
        constructor=fortinet,
        defaults={
            "command_text": "config router static\nedit 0\nset dst {destination} {mask}\nset gateway {next_hop}\nnext\nend",
            "example": "config router static\nedit 0\nset dst 10.0.0.0 255.255.255.0\nset gateway 192.168.1.1\nnext\nend",
            "notes": "Utilisez 'edit 0' pour une nouvelle entrée."
        }
    )

    # Action 3 : Vérifier l'état des voisins BGP
    action3 = CommandAction.objects.get(title="Vérifier l'état des voisins BGP")
    CommandVariant.objects.get_or_create(
        action=action3,
        constructor=cisco,
        defaults={
            "command_text": "show ip bgp summary",
            "example": "show ip bgp summary",
            "notes": "Affiche l'état des sessions BGP (Established, Idle, etc.)."
        }
    )
    CommandVariant.objects.get_or_create(
        action=action3,
        constructor=huawei,
        defaults={
            "command_text": "display bgp peer",
            "example": "display bgp peer",
            "notes": "Ajoutez 'verbose' pour plus de détails."
        }
    )
    CommandVariant.objects.get_or_create(
        action=action3,
        constructor=juniper,
        defaults={
            "command_text": "show bgp summary",
            "example": "show bgp summary",
            "notes": "Utilisez 'show bgp neighbor' pour des détails par voisin."
        }
    )
    CommandVariant.objects.get_or_create(
        action=action3,
        constructor=mikrotik,
        defaults={
            "command_text": "ip bgp peer print",
            "example": "ip bgp peer print",
            "notes": "Affiche l'état des pairs BGP."
        }
    )
    CommandVariant.objects.get_or_create(
        action=action3,
        constructor=fortinet,
        defaults={
            "command_text": "get router info bgp summary",
            "example": "get router info bgp summary",
            "notes": "Vérifiez les VDOM si configurés."
        }
    )

    # Action 4 : Afficher la table MAC
    action4 = CommandAction.objects.get(title="Afficher la table MAC")
    CommandVariant.objects.get_or_create(
        action=action4,
        constructor=cisco,
        defaults={
            "command_text": "show mac address-table",
            "example": "show mac address-table",
            "notes": "Ajoutez 'dynamic' pour filtrer les entrées apprises."
        }
    )
    CommandVariant.objects.get_or_create(
        action=action4,
        constructor=huawei,
        defaults={
            "command_text": "display mac-address",
            "example": "display mac-address",
            "notes": "Utilisez 'vlan {vlan_id}' pour filtrer."
        }
    )
    CommandVariant.objects.get_or_create(
        action=action4,
        constructor=juniper,
        defaults={
            "command_text": "show ethernet-switching table",
            "example": "show ethernet-switching table",
            "notes": "Ajoutez 'brief' pour un résumé."
        }
    )
    CommandVariant.objects.get_or_create(
        action=action4,
        constructor=mikrotik,
        defaults={
            "command_text": "interface bridge host print",
            "example": "interface bridge host print",
            "notes": "Affiche les hôtes appris sur le bridge."
        }
    )
    CommandVariant.objects.get_or_create(
        action=action4,
        constructor=fortinet,
        defaults={
            "command_text": "diagnose switch mac-address list",
            "example": "diagnose switch mac-address list",
            "notes": "Disponible sur les modèles avec switching."
        }
    )

    # Action 5 : Configurer un VLAN
    action5 = CommandAction.objects.get(title="Configurer un VLAN")
    CommandVariant.objects.get_or_create(
        action=action5,
        constructor=cisco,
        defaults={
            "command_text": "vlan {vlan_id}\nname {vlan_name}\nexit",
            "example": "vlan 10\nname SALES\nexit",
            "notes": "Utilisez 'show vlan brief' pour vérifier."
        }
    )
    CommandVariant.objects.get_or_create(
        action=action5,
        constructor=huawei,
        defaults={
            "command_text": "vlan {vlan_id}\ndescription {vlan_name}\nquit",
            "example": "vlan 10\ndescription SALES\nquit",
            "notes": "Vérifiez avec 'display vlan'."
        }
    )
    CommandVariant.objects.get_or_create(
        action=action5,
        constructor=juniper,
        defaults={
            "command_text": "set vlans {vlan_name} vlan-id {vlan_id}",
            "example": "set vlans SALES vlan-id 10",
            "notes": "Utilisez 'commit' pour appliquer."
        }
    )
    CommandVariant.objects.get_or_create(
        action=action5,
        constructor=mikrotik,
        defaults={
            "command_text": "interface vlan add name={vlan_name} vlan-id={vlan_id} interface={interface}",
            "example": "interface vlan add name=SALES vlan-id=10 interface=ether1",
            "notes": "Liez à une interface existante."
        }
    )
    CommandVariant.objects.get_or_create(
        action=action5,
        constructor=fortinet,
        defaults={
            "command_text": "config system interface\nedit vlan{vlan_id}\nset vdom root\nset vlanid {vlan_id}\nset interface {interface}\nnext\nend",
            "example": "config system interface\nedit vlan10\nset vdom root\nset vlanid 10\nset interface port1\nnext\nend",
            "notes": "Associez à une interface physique."
        }
    )

    # Action 6 : Vérifier l'état d'une interface
    action6 = CommandAction.objects.get(title="Vérifier l'état d'une interface")
    CommandVariant.objects.get_or_create(
        action=action6,
        constructor=cisco,
        defaults={
            "command_text": "show interfaces {interface}",
            "example": "show interfaces GigabitEthernet0/1",
            "notes": "Affiche état, erreurs, et statistiques."
        }
    )
    CommandVariant.objects.get_or_create(
        action=action6,
        constructor=huawei,
        defaults={
            "command_text": "display interface {interface}",
            "example": "display interface GigabitEthernet0/0/1",
            "notes": "Ajoutez 'brief' pour un résumé."
        }
    )
    CommandVariant.objects.get_or_create(
        action=action6,
        constructor=juniper,
        defaults={
            "command_text": "show interfaces {interface}",
            "example": "show interfaces ge-0/0/1",
            "notes": "Ajoutez 'detail' pour plus d'infos."
        }
    )
    CommandVariant.objects.get_or_create(
        action=action6,
        constructor=mikrotik,
        defaults={
            "command_text": "interface print detail where name={interface}",
            "example": "interface print detail where name=ether1",
            "notes": "Vérifiez l'état (running, disabled)."
        }
    )
    CommandVariant.objects.get_or_create(
        action=action6,
        constructor=fortinet,
        defaults={
            "command_text": "diagnose hardware deviceinfo nic {interface}",
            "example": "diagnose hardware deviceinfo nic port1",
            "notes": "Utilisez 'get system interface' pour un résumé."
        }
    )

    # Action 7 : Afficher les règles de pare-feu
    action7 = CommandAction.objects.get(title="Afficher les règles de pare-feu")
    CommandVariant.objects.get_or_create(
        action=action7,
        constructor=cisco,
        defaults={
            "command_text": "show access-lists",
            "example": "show access-lists",
            "notes": "Affiche les ACL appliquées."
        }
    )
    CommandVariant.objects.get_or_create(
        action=action7,
        constructor=huawei,
        defaults={
            "command_text": "display acl all",
            "example": "display acl all",
            "notes": "Ajoutez 'name {acl_name}' pour une ACL spécifique."
        }
    )
    CommandVariant.objects.get_or_create(
        action=action7,
        constructor=juniper,
        defaults={
            "command_text": "show firewall",
            "example": "show firewall",
            "notes": "Affiche les filtres de pare-feu."
        }
    )
    CommandVariant.objects.get_or_create(
        action=action7,
        constructor=mikrotik,
        defaults={
            "command_text": "ip firewall filter print",
            "example": "ip firewall filter print",
            "notes": "Affiche les règles de filtrage."
        }
    )
    CommandVariant.objects.get_or_create(
        action=action7,
        constructor=fortinet,
        defaults={
            "command_text": "get firewall policy",
            "example": "get firewall policy",
            "notes": "Affiche les politiques par VDOM."
        }
    )

    # Action 8 : Configurer une liste de contrôle d'accès
    action8 = CommandAction.objects.get(title="Configurer une liste de contrôle d'accès")
    CommandVariant.objects.get_or_create(
        action=action8,
        constructor=cisco,
        defaults={
            "command_text": "access-list {acl_id} {action} {protocol} {source} {destination}",
            "example": "access-list 100 permit tcp 192.168.1.0 0.0.0.255 10.0.0.0 0.0.0.255",
            "notes": "Appliquez l'ACL avec 'ip access-group'."
        }
    )
    CommandVariant.objects.get_or_create(
        action=action8,
        constructor=huawei,
        defaults={
            "command_text": "acl number {acl_id}\nrule 5 {action} {protocol} source {source} destination {destination}\nquit",
            "example": "acl number 2000\nrule 5 permit tcp source 192.168.1.0/24 destination 10.0.0.0/24\nquit",
            "notes": "Utilisez 'traffic-filter' pour appliquer."
        }
    )
    CommandVariant.objects.get_or_create(
        action=action8,
        constructor=juniper,
        defaults={
            "command_text": "set firewall family inet filter {acl_name} term 1 from source-address {source} destination-address {destination} protocol {protocol} then {action}",
            "example": "set firewall family inet filter ACL1 term 1 from source-address 192.168.1.0/24 destination-address 10.0.0.0/24 protocol tcp then accept",
            "notes": "Utilisez 'commit' pour appliquer."
        }
    )
    CommandVariant.objects.get_or_create(
        action=action8,
        constructor=mikrotik,
        defaults={
            "command_text": "ip firewall filter add chain=forward action={action} protocol={protocol} src-address={source} dst-address={destination}",
            "example": "ip firewall filter add chain=forward action=accept protocol=tcp src-address=192.168.1.0/24 dst-address=10.0.0.0/24",
            "notes": "Placez la règle dans la bonne chaîne."
        }
    )
    CommandVariant.objects.get_or_create(
        action=action8,
        constructor=fortinet,
        defaults={
            "command_text": "config firewall policy\nedit 0\nset srcaddr {source}\nset dstaddr {destination}\nset action {action}\nset service {protocol}\nnext\nend",
            "example": "config firewall policy\nedit 0\nset srcaddr 192.168.1.0/24\nset dstaddr 10.0.0.0/24\nset action accept\nset service TCP\nnext\nend",
            "notes": "Configurez les adresses et services avant."
        }
    )

    # Action 9 : Vérifier les sessions VPN
    action9 = CommandAction.objects.get(title="Vérifier les sessions VPN")
    CommandVariant.objects.get_or_create(
        action=action9,
        constructor=cisco,
        defaults={
            "command_text": "show crypto isakmp sa",
            "example": "show crypto isakmp sa",
            "notes": "Affiche les sessions IPsec IKEv1."
        }
    )
    CommandVariant.objects.get_or_create(
        action=action9,
        constructor=huawei,
        defaults={
            "command_text": "display ike sa",
            "example": "display ike sa",
            "notes": "Ajoutez 'verbose' pour plus de détails."
        }
    )
    CommandVariant.objects.get_or_create(
        action=action9,
        constructor=juniper,
        defaults={
            "command_text": "show security ike security-associations",
            "example": "show security ike security-associations",
            "notes": "Utilisez 'detail' pour plus d'infos."
        }
    )
    CommandVariant.objects.get_or_create(
        action=action9,
        constructor=mikrotik,
        defaults={
            "command_text": "ip ipsec active-peers print",
            "example": "ip ipsec active-peers print",
            "notes": "Affiche les pairs IPsec actifs."
        }
    )
    CommandVariant.objects.get_or_create(
        action=action9,
        constructor=fortinet,
        defaults={
            "command_text": "diagnose vpn tunnel list",
            "example": "diagnose vpn tunnel list",
            "notes": "Affiche les tunnels IPsec par VDOM."
        }
    )

    # --- Table CommandAlias ---
    # Création de 2 alias par constructeur
    CommandAlias.objects.get_or_create(
        constructor=cisco,
        alias_text="sh",
        defaults={
            "full_command": "show"
        }
    )
    CommandAlias.objects.get_or_create(
        constructor=cisco,
        alias_text="sh ip ro",
        defaults={
            "full_command": "show ip route"
        }
    )
    CommandAlias.objects.get_or_create(
        constructor=huawei,
        alias_text="dis",
        defaults={
            "full_command": "display"
        }
    )
    CommandAlias.objects.get_or_create(
        constructor=huawei,
        alias_text="dis ip ro",
        defaults={
            "full_command": "display ip routing-table"
        }
    )
    CommandAlias.objects.get_or_create(
        constructor=juniper,
        alias_text="sh",
        defaults={
            "full_command": "show"
        }
    )
    CommandAlias.objects.get_or_create(
        constructor=juniper,
        alias_text="sh ro",
        defaults={
            "full_command": "show route"
        }
    )
    CommandAlias.objects.get_or_create(
        constructor=mikrotik,
        alias_text="ip ro pr",
        defaults={
            "full_command": "ip route print"
        }
    )
    CommandAlias.objects.get_or_create(
        constructor=mikrotik,
        alias_text="int pr",
        defaults={
            "full_command": "interface print"
        }
    )
    CommandAlias.objects.get_or_create(
        constructor=fortinet,
        alias_text="get ro",
        defaults={
            "full_command": "get router info routing-table all"
        }
    )
    CommandAlias.objects.get_or_create(
        constructor=fortinet,
        alias_text="diag vpn",
        defaults={
            "full_command": "diagnose vpn tunnel list"
        }
    )

    # --- Table CommandParameter ---
    # Création de 4 paramètres courants
    CommandParameter.objects.get_or_create(
        name="ip",
        defaults={
            "description": "Adresse IPv4 (ex. 192.168.1.1)",
            "validation_regex": "^(\\d{1,3}\\.){3}\\d{1,3}$"
        }
    )
    CommandParameter.objects.get_or_create(
        name="mask",
        defaults={
            "description": "Masque de sous-réseau (ex. 255.255.255.0)",
            "validation_regex": "^(255\\.){0,3}(0|128|192|224|240|248|252|254|255)$"
        }
    )
    CommandParameter.objects.get_or_create(
        name="interface",
        defaults={
            "description": "Nom de l'interface (ex. GigabitEthernet0/1, eth0)",
            "validation_regex": "^[a-zA-Z0-9/\\-]+$"
        }
    )
    CommandParameter.objects.get_or_create(
        name="vlan_id",
        defaults={
            "description": "Identifiant VLAN (1-4094)",
            "validation_regex": "^[1-9][0-9]{0,3}$"
        }
    )

if __name__ == "__main__":
    run()