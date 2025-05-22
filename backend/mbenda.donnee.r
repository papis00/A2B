# --- Table CommandAction ---

# --- Catégorie Management ---
CommandAction.objects.create(
    title="Entrer en mode configuration",
    category="management",
    description="Passe en mode configuration globale pour modifier la configuration du dispositif."
)

CommandAction.objects.create(
    title="Afficher la configuration en cours",
    category="management",
    description="Montre la configuration active actuellement chargée sur l'appareil."
)

CommandAction.objects.create(
    title="Afficher les informations système",
    category="management",
    description="Donne des informations sur la version du système d'exploitation et le matériel."
)

CommandAction.objects.create(
    title="Afficher les utilisateurs connectés",
    category="management",
    description="Liste les sessions utilisateurs actives sur l'appareil."
)

# --- Catégorie Monitoring ---
CommandAction.objects.create(
    title="Vérifier les statistiques d'interface",
    category="monitoring",
    description="Affiche les compteurs de trafic et erreurs sur les interfaces."
)

CommandAction.objects.create(
    title="Afficher les associations NTP",
    category="monitoring",
    description="Montre l'état de synchronisation avec les serveurs de temps."
)

CommandAction.objects.create(
    title="Vérifier les opérations SLA",
    category="monitoring",
    description="Affiche les résultats des mesures de performance réseau (SLA)."
)

# --- Catégorie Routing (supplémentaires) ---
CommandAction.objects.create(
    title="Afficher les voisins OSPF",
    category="routing",
    description="Montre l'état des adjacences OSPF établies."
)

CommandAction.objects.create(
    title="Afficher la table multicast",
    category="routing",
    description="Liste les routes multicast actives (mroute)."
)

# --- Catégorie Switching (supplémentaires) ---
CommandAction.objects.create(
    title="Afficher l'état du spanning-tree",
    category="switching",
    description="Montre la topologie STP et les rôles des ports."
)

CommandAction.objects.create(
    title="Afficher les groupes IGMP",
    category="switching",
    description="Liste les abonnements multicast sur les interfaces."
)

# --- Catégorie Security (supplémentaires) ---
CommandAction.objects.create(
    title="Afficher les traductions NAT",
    category="security",
    description="Montre les translations d'adresses actives."
)

CommandAction.objects.create(
    title="Vérifier les sessions IPsec",
    category="security",
    description="Affiche l'état des tunnels VPN IPsec."
)

#################################################################################
# --- Table CommandVariant ---


# Action: Entrer en mode configuration
action_config = CommandAction.objects.get(title="Entrer en mode configuration")
CommandVariant.objects.create(
    action=action_config,
    constructor=cisco,
    command_text="configure terminal",
    example="configure terminal",
    notes="Mode configuration globale"
)
CommandVariant.objects.create(
    action=action_config,
    constructor=juniper,
    command_text="cli",
    example="cli",
    notes="Mode configuration opérationnel"
)
CommandVariant.objects.create(
    action=action_config,
    constructor=huawei,
    command_text="system-view",
    example="system-view",
    notes="Passe en mode système"
)
CommandVariant.objects.create(
    action=action_config,
    constructor=fortinet,
    command_text="config global",
    example="config global",
    notes="Mode configuration globale"
)
CommandVariant.objects.create(
    action=action_config,
    constructor=mikrotik,
    command_text="/system console",
    example="/system console",
    notes="Mode configuration dans RouterOS"
)

# Action: Configurer une interface
action_interface = CommandAction.objects.get(title="Configurer une interface")
CommandVariant.objects.create(
    action=action_interface,
    constructor=cisco,
    command_text="interface FastEthernet 0/1",
    example="interface GigabitEthernet0/0/1",
    notes="Accède à la configuration d'interface"
)
CommandVariant.objects.create(
    action=action_interface,
    constructor=juniper,
    command_text="edit interfaces ge-0/0/0",
    example="edit interfaces ge-0/0/0",
    notes="Mode édition de l'interface"
)
CommandVariant.objects.create(
    action=action_interface,
    constructor=huawei,
    command_text="interface GigabitEthernet 0/0/1",
    example="interface GigabitEthernet0/0/1",
    notes="Accès configuration interface"
)
CommandVariant.objects.create(
    action=action_interface,
    constructor=fortinet,
    command_text="config system interface",
    example="config system interface",
    notes="Mode configuration interface"
)
CommandVariant.objects.create(
    action=action_interface,
    constructor=mikrotik,
    command_text="interface ethernet set [find name=ether1]",
    example="interface ethernet set [find name=ether1]",
    notes="Modifie les paramètres de l'interface"
)

# Action: Configurer une adresse IP
action_ip = CommandAction.objects.get(title="Configurer une adresse IP")
CommandVariant.objects.create(
    action=action_ip,
    constructor=cisco,
    command_text="ip address 192.168.1.1 255.255.255.0",
    example="ip address 192.168.1.1 255.255.255.0",
    notes="Configuration en mode interface"
)
CommandVariant.objects.create(
    action=action_ip,
    constructor=juniper,
    command_text="set address 192.168.1.1/24",
    example="set address 192.168.1.1/24",
    notes="En mode édition d'interface"
)
CommandVariant.objects.create(
    action=action_ip,
    constructor=huawei,
    command_text="ip address 192.168.1.1 255.255.255.0",
    example="ip address 192.168.1.1 255.255.255.0",
    notes="Configuration en mode interface"
)
CommandVariant.objects.create(
    action=action_ip,
    constructor=fortinet,
    command_text="set ip 192.168.1.1/24",
    example="set ip 192.168.1.1/24",
    notes="En mode configuration d'interface"
)
CommandVariant.objects.create(
    action=action_ip,
    constructor=mikrotik,
    command_text="ip address add address=192.168.1.1/24 interface=ether1",
    example="ip address add address=192.168.1.1/24 interface=ether1",
    notes="Configuration IP sur l'interface"
)

# Action: Afficher les interfaces
action_show_intf = CommandAction.objects.get(title="Vérifier l'état d'une interface")
CommandVariant.objects.create(
    action=action_show_intf,
    constructor=cisco,
    command_text="show ip interface brief",
    example="show ip interface brief",
    notes="Affiche un résumé des interfaces"
)
CommandVariant.objects.create(
    action=action_show_intf,
    constructor=juniper,
    command_text="show interfaces terse",
    example="show interfaces terse",
    notes="Vue condensée des interfaces"
)
CommandVariant.objects.create(
    action=action_show_intf,
    constructor=huawei,
    command_text="display ip interface brief",
    example="display ip interface brief",
    notes="Résumé des interfaces IP"
)
CommandVariant.objects.create(
    action=action_show_intf,
    constructor=fortinet,
    command_text="get system interface",
    example="get system interface",
    notes="Liste toutes les interfaces"
)
CommandVariant.objects.create(
    action=action_show_intf,
    constructor=mikrotik,
    command_text="interface print",
    example="interface print",
    notes="Affiche l'état des interfaces"
)

#################################################################"

# --- Table CommandVariant ---


# Action: Afficher les statistiques NTP
action_ntp = CommandAction.objects.get(title="Afficher les associations NTP")
CommandVariant.objects.create(
    action=action_ntp,
    constructor=cisco,
    command_text="show ntp associations",
    example="show ntp associations",
    notes="Affiche les serveurs NTP et leur statut de synchronisation"
)
CommandVariant.objects.create(
    action=action_ntp,
    constructor=juniper,
    command_text="show ntp associations",
    example="show ntp associations",
    notes="Liste les associations NTP actives"
)
CommandVariant.objects.create(
    action=action_ntp,
    constructor=huawei,
    command_text="display ntp associations",
    example="display ntp associations",
    notes="Montre les pairs NTP et leur état"
)
CommandVariant.objects.create(
    action=action_ntp,
    constructor=fortinet,
    command_text="get system ntp associations",
    example="get system ntp associations",
    notes="Affiche les associations NTP"
)
CommandVariant.objects.create(
    action=action_ntp,
    constructor=mikrotik,
    command_text="system ntp client print",
    example="system ntp client print",
    notes="Affiche la configuration et statut du client NTP"
)

# Action: Afficher l'uptime du système
action_uptime = CommandAction.objects.get(title="Afficher les informations système")
CommandVariant.objects.create(
    action=action_uptime,
    constructor=cisco,
    command_text="show clock",
    example="show clock",
    notes="Affiche aussi l'heure système"
)
CommandVariant.objects.create(
    action=action_uptime,
    constructor=juniper,
    command_text="show system uptime",
    example="show system uptime",
    notes="Montre le temps depuis le dernier reboot"
)
CommandVariant.objects.create(
    action=action_uptime,
    constructor=huawei,
    command_text="display time",
    example="display time",
    notes="Affiche l'heure et la durée de fonctionnement"
)
CommandVariant.objects.create(
    action=action_uptime,
    constructor=fortinet,
    command_text="get system uptime",
    example="get system uptime",
    notes="Montre l'uptime et l'utilisation CPU"
)
CommandVariant.objects.create(
    action=action_uptime,
    constructor=mikrotik,
    command_text="system resource print",
    example="system resource print",
    notes="Affiche uptime, charge CPU et mémoire"
)

# Action: Vérifier les opérations SLA
action_sla = CommandAction.objects.get(title="Vérifier les opérations SLA")
CommandVariant.objects.create(
    action=action_sla,
    constructor=cisco,
    command_text="show ip sla statistics",
    example="show ip sla statistics 1",
    notes="Affiche les statistiques des opérations SLA"
)
CommandVariant.objects.create(
    action=action_sla,
    constructor=juniper,
    command_text="show sla statistics",
    example="show sla statistics",
    notes="Statistiques des mesures SLA"
)
CommandVariant.objects.create(
    action=action_sla,
    constructor=huawei,
    command_text="display sla statistics",
    example="display sla statistics",
    notes="Résultats des opérations SLA"
)
CommandVariant.objects.create(
    action=action_sla,
    constructor=fortinet,
    command_text="get system sla statistics",
    example="get system sla statistics",
    notes="Affiche les statistiques SLA"
)
CommandVariant.objects.create(
    action=action_sla,
    constructor=mikrotik,
    command_text="tool netwatch print",
    example="tool netwatch print",
    notes="Montre le statut des monitors réseau"
)

# Action: Afficher les voisins OSPF
action_ospf = CommandAction.objects.get(title="Afficher les voisins OSPF")
CommandVariant.objects.create(
    action=action_ospf,
    constructor=cisco,
    command_text="show ip ospf neighbor",
    example="show ip ospf neighbor",
    notes="Liste les adjacences OSPF établies"
)
CommandVariant.objects.create(
    action=action_ospf,
    constructor=juniper,
    command_text="show ospf neighbor",
    example="show ospf neighbor",
    notes="Affiche les voisins OSPF"
)
CommandVariant.objects.create(
    action=action_ospf,
    constructor=huawei,
    command_text="display ospf peer",
    example="display ospf peer",
    notes="Montre les pairs OSPF"
)
CommandVariant.objects.create(
    action=action_ospf,
    constructor=fortinet,
    command_text="get router ospf neighbor",
    example="get router ospf neighbor",
    notes="Liste des voisins OSPF"
)
CommandVariant.objects.create(
    action=action_ospf,
    constructor=mikrotik,
    command_text="routing ospf neighbor print",
    example="routing ospf neighbor print",
    notes="Affiche les voisins OSPF"
)
# D'abord créer l'action BGP si elle n'existe pas
action_bgp, created = CommandAction.objects.get_or_create(
    title="Afficher le résumé BGP",
    defaults={
        'category': 'routing',
        'description': "Affiche un résumé des sessions BGP et l'état des peers"
    }
)

# Ensuite créer les variantes
CommandVariant.objects.create(
    action=action_bgp,
    constructor=cisco,
    command_text="show ip bgp summary",
    example="show ip bgp summary",
    notes="Résumé des sessions BGP"
)
CommandVariant.objects.create(
    action=action_bgp,
    constructor=juniper,
    command_text="show bgp summary",
    example="show bgp summary",
    notes="Statut des sessions BGP"
)
CommandVariant.objects.create(
    action=action_bgp,
    constructor=huawei,
    command_text="display bgp summary",
    example="display bgp summary",
    notes="Résumé des peers BGP"
)
CommandVariant.objects.create(
    action=action_bgp,
    constructor=fortinet,
    command_text="get router info bgp summary",
    example="get router info bgp summary",
    notes="Affiche le résumé BGP"
)
CommandVariant.objects.create(
    action=action_bgp,
    constructor=mikrotik,
    command_text="routing bgp peer print",
    example="routing bgp peer print",
    notes="Liste des pairs BGP et leur état"
)

############################################################

# --- Table CommandVariant ---


# Action: Afficher les interfaces trunk
action_trunk = CommandAction.objects.get_or_create(
    title="Afficher les interfaces trunk",
    defaults={
        'category': 'switching',
        'description': "Affiche les interfaces configurées en mode trunk"
    }
)[0]

CommandVariant.objects.create(
    action=action_trunk,
    constructor=cisco,
    command_text="show interfaces trunk",
    example="show interfaces trunk",
    notes="Liste les ports en mode trunk"
)
CommandVariant.objects.create(
    action=action_trunk,
    constructor=juniper,
    command_text="show interfaces extensive",
    example="show interfaces extensive | match trunk",
    notes="Requiert un filtrage pour voir spécifiquement les trunks"
)
CommandVariant.objects.create(
    action=action_trunk,
    constructor=huawei,
    command_text="display interface trunk",
    example="display interface trunk",
    notes="Affiche les interfaces en mode trunk"
)
CommandVariant.objects.create(
    action=action_trunk,
    constructor=fortinet,
    command_text="show system interface trunk",
    example="show system interface trunk",
    notes="Liste les interfaces trunk"
)
CommandVariant.objects.create(
    action=action_trunk,
    constructor=mikrotik,
    command_text="interface bridge port print where role=trunk",
    example="interface bridge port print where role=trunk",
    notes="Affiche les ports configurés en trunk"
)

# Action: Afficher la topologie spanning-tree
action_stp = CommandAction.objects.get_or_create(
    title="Afficher l'état du spanning-tree",
    defaults={
        'category': 'switching',
        'description': "Affiche la topologie STP et les rôles des ports"
    }
)[0]

CommandVariant.objects.create(
    action=action_stp,
    constructor=cisco,
    command_text="show spanning-tree",
    example="show spanning-tree",
    notes="Affiche la topologie STP globale"
)
CommandVariant.objects.create(
    action=action_stp,
    constructor=juniper,
    command_text="show spanning-tree",
    example="show spanning-tree",
    notes="Topologie STP pour tous les VLANs"
)
CommandVariant.objects.create(
    action=action_stp,
    constructor=huawei,
    command_text="display spanning-tree",
    example="display spanning-tree",
    notes="Affiche la configuration STP"
)
CommandVariant.objects.create(
    action=action_stp,
    constructor=fortinet,
    command_text="show system spanning-tree",
    example="show system spanning-tree",
    notes="Statut du spanning-tree"
)
CommandVariant.objects.create(
    action=action_stp,
    constructor=mikrotik,
    command_text="interface bridge monitor",
    example="interface bridge monitor [find where name=bridge1]",
    notes="Affiche l'état du bridge (équivalent STP)"
)

# Action: Afficher les groupes IGMP
action_igmp = CommandAction.objects.get_or_create(
    title="Afficher les groupes IGMP",
    defaults={
        'category': 'switching',
        'description': "Liste les abonnements multicast sur les interfaces"
    }
)[0]

CommandVariant.objects.create(
    action=action_igmp,
    constructor=cisco,
    command_text="show ip igmp groups",
    example="show ip igmp groups",
    notes="Affiche les groupes multicast joints"
)
CommandVariant.objects.create(
    action=action_igmp,
    constructor=juniper,
    command_text="show igmp groups",
    example="show igmp groups",
    notes="Liste des abonnements multicast"
)
CommandVariant.objects.create(
    action=action_igmp,
    constructor=huawei,
    command_text="display igmp groups",
    example="display igmp groups",
    notes="Affiche les groupes IGMP"
)
CommandVariant.objects.create(
    action=action_igmp,
    constructor=fortinet,
    command_text="show system igmp",
    example="show system igmp",
    notes="Statut IGMP et groupes"
)
CommandVariant.objects.create(
    action=action_igmp,
    constructor=mikrotik,
    command_text="igmp proxy print",
    example="igmp proxy print",
    notes="Affiche la configuration IGMP"
)

# Action: Afficher la table multicast
action_mroute = CommandAction.objects.get_or_create(
    title="Afficher la table multicast",
    defaults={
        'category': 'routing',
        'description': "Liste les routes multicast actives (mroute)"
    }
)[0]

CommandVariant.objects.create(
    action=action_mroute,
    constructor=cisco,
    command_text="show ip mroute",
    example="show ip mroute",
    notes="Affiche la table multicast"
)
CommandVariant.objects.create(
    action=action_mroute,
    constructor=juniper,
    command_text="show mroute",
    example="show mroute",
    notes="Table de routage multicast"
)
CommandVariant.objects.create(
    action=action_mroute,
    constructor=huawei,
    command_text="display ip mroute",
    example="display ip mroute",
    notes="Routes multicast actives"
)
CommandVariant.objects.create(
    action=action_mroute,
    constructor=fortinet,
    command_text="show router mroute",
    example="show router mroute",
    notes="Affiche la table mroute"
)
CommandVariant.objects.create(
    action=action_mroute,
    constructor=mikrotik,
    command_text="routing multicast print",
    example="routing multicast print",
    notes="Affiche les routes multicast"
)

########################################################

# --- Table CommandVariant ---

# Action: Afficher les règles de pare-feu
action_fw = CommandAction.objects.get_or_create(
    title="Afficher les règles de pare-feu",
    defaults={
        'category': 'security',
        'description': "Liste les règles de filtrage appliquées pour sécuriser le trafic"
    }
)[0]

CommandVariant.objects.create(
    action=action_fw,
    constructor=cisco,
    command_text="show access-list",
    example="show access-list",
    notes="Affiche toutes les ACL configurées"
)
CommandVariant.objects.create(
    action=action_fw,
    constructor=juniper,
    command_text="show firewall",
    example="show firewall",
    notes="Liste les règles de filtrage"
)
CommandVariant.objects.create(
    action=action_fw,
    constructor=huawei,
    command_text="display acl",
    example="display acl all",
    notes="Affiche toutes les ACL"
)
CommandVariant.objects.create(
    action=action_fw,
    constructor=fortinet,
    command_text="show firewall policy",
    example="show firewall policy",
    notes="Liste les règles de pare-feu"
)
CommandVariant.objects.create(
    action=action_fw,
    constructor=mikrotik,
    command_text="ip firewall filter print",
    example="ip firewall filter print",
    notes="Affiche les règles de filtrage"
)

# Action: Afficher les logs système
action_logs = CommandAction.objects.get_or_create(
    title="Afficher les logs système",
    defaults={
        'category': 'management',
        'description': "Affiche le buffer des logs système"
    }
)[0]

CommandVariant.objects.create(
    action=action_logs,
    constructor=cisco,
    command_text="show logging",
    example="show logging",
    notes="Affiche le buffer de logs"
)
CommandVariant.objects.create(
    action=action_logs,
    constructor=juniper,
    command_text="show log",
    example="show log",
    notes="Journal des événements système"
)
CommandVariant.objects.create(
    action=action_logs,
    constructor=huawei,
    command_text="display logbuffer",
    example="display logbuffer",
    notes="Affiche le buffer de logs"
)
CommandVariant.objects.create(
    action=action_logs,
    constructor=fortinet,
    command_text="get log memory",
    example="get log memory",
    notes="Logs en mémoire"
)
CommandVariant.objects.create(
    action=action_logs,
    constructor=mikrotik,
    command_text="log print",
    example="log print",
    notes="Affiche les logs système"
)

# Action: Vérifier les sessions VPN IPsec
action_ipsec = CommandAction.objects.get_or_create(
    title="Vérifier les sessions VPN",
    defaults={
        'category': 'security',
        'description': "Affiche les tunnels VPN IPsec actifs"
    }
)[0]

CommandVariant.objects.create(
    action=action_ipsec,
    constructor=cisco,
    command_text="show crypto ipsec sa",
    example="show crypto ipsec sa",
    notes="Statut des tunnels IPsec"
)
CommandVariant.objects.create(
    action=action_ipsec,
    constructor=juniper,
    command_text="show ipsec sa",
    example="show ipsec sa",
    notes="Sessions de sécurité IPsec"
)
CommandVariant.objects.create(
    action=action_ipsec,
    constructor=huawei,
    command_text="display ipsec sa",
    example="display ipsec sa",
    notes="Affiche les SA IPsec"
)
CommandVariant.objects.create(
    action=action_ipsec,
    constructor=fortinet,
    command_text="show vpn ipsec sa",
    example="show vpn ipsec sa",
    notes="Liste des tunnels IPsec"
)
CommandVariant.objects.create(
    action=action_ipsec,
    constructor=mikrotik,
    command_text="ipsec active-peers print",
    example="ipsec active-peers print",
    notes="Pairs IPsec actifs"
)

# Action: Afficher les informations environnementales
action_env = CommandAction.objects.get_or_create(
    title="Afficher l'état environnemental",
    defaults={
        'category': 'management',
        'description': "Affiche les informations hardware (température, ventilateurs)"
    }
)[0]

CommandVariant.objects.create(
    action=action_env,
    constructor=cisco,
    command_text="show environment",
    example="show environment all",
    notes="Statut des composants hardware"
)
CommandVariant.objects.create(
    action=action_env,
    constructor=juniper,
    command_text="show chassis environment",
    example="show chassis environment",
    notes="Conditions environnementales"
)
CommandVariant.objects.create(
    action=action_env,
    constructor=huawei,
    command_text="display environment",
    example="display environment",
    notes="Affiche l'état du hardware"
)
CommandVariant.objects.create(
    action=action_env,
    constructor=fortinet,
    command_text="get system sensor",
    example="get system sensor",
    notes="Capteurs environnementaux"
)
CommandVariant.objects.create(
    action=action_env,
    constructor=mikrotik,
    command_text="system health print",
    example="system health print",
    notes="État du système et températures"
)

# Action: Afficher les voisins CDP/LLDP
action_neighbors = CommandAction.objects.get_or_create(
    title="Afficher les voisins réseau",
    defaults={
        'category': 'management',
        'description': "Liste les appareils directement connectés (découverts via CDP/LLDP)"
    }
)[0]

CommandVariant.objects.create(
    action=action_neighbors,
    constructor=cisco,
    command_text="show cdp neighbors detail",
    example="show cdp neighbors detail",
    notes="Détails des voisins CDP"
)
CommandVariant.objects.create(
    action=action_neighbors,
    constructor=juniper,
    command_text="show lldp neighbors",
    example="show lldp neighbors",
    notes="Voisins LLDP"
)
CommandVariant.objects.create(
    action=action_neighbors,
    constructor=huawei,
    command_text="display lldp neighbor brief",
    example="display lldp neighbor brief",
    notes="Liste des voisins LLDP"
)
CommandVariant.objects.create(
    action=action_neighbors,
    constructor=fortinet,
    command_text="get system lldp neighbors",
    example="get system lldp neighbors",
    notes="Voisins découverts via LLDP"
)
CommandVariant.objects.create(
    action=action_neighbors,
    constructor=mikrotik,
    command_text="interface ethernet monitor lldp",
    example="interface ethernet monitor lldp once",
    notes="Affiche les voisins LLDP"
)

########################################################

# --- Table CommandVariant ---


# Action: Afficher les informations environnementales 
action_env, created = CommandAction.objects.get_or_create(
    title="Afficher l'état environnemental",
    defaults={
        'category': 'management',
        'description': "Affiche les informations hardware (température, ventilateurs)"
    }
)

if created:
    # Variantes environnement (uniquement si l'action est nouvelle)
    CommandVariant.objects.create(
        action=action_env,
        constructor=cisco,
        command_text="show environment",
        example="show environment all",
        notes="Statut des composants hardware"
    )
    CommandVariant.objects.create(
        action=action_env,
        constructor=juniper,
        command_text="show chassis environment",
        example="show chassis environment",
        notes="Conditions environnementales"
    )
    CommandVariant.objects.create(
        action=action_env,
        constructor=huawei,
        command_text="display environment",
        example="display environment",
        notes="Affiche l'état du hardware"
    )
    CommandVariant.objects.create(
        action=action_env,
        constructor=fortinet,
        command_text="get system sensor",
        example="get system sensor",
        notes="Capteurs environnementaux"
    )
    CommandVariant.objects.create(
        action=action_env,
        constructor=mikrotik,
        command_text="system health print",
        example="system health print",
        notes="État du système et températures"
    )

# Action: Afficher les voisins CDP/LLDP 
action_neighbors, created = CommandAction.objects.get_or_create(
    title="Afficher les voisins réseau",
    defaults={
        'category': 'management',
        'description': "Liste les appareils directement connectés (découverts via CDP/LLDP)"
    }
)

if created:
    # Variantes voisins réseau 
    CommandVariant.objects.create(
        action=action_neighbors,
        constructor=cisco,
        command_text="show cdp neighbors detail",
        example="show cdp neighbors detail",
        notes="Détails des voisins CDP"
    )
    CommandVariant.objects.create(
        action=action_neighbors,
        constructor=juniper,
        command_text="show lldp neighbors",
        example="show lldp neighbors",
        notes="Voisins LLDP"
    )
    CommandVariant.objects.create(
        action=action_neighbors,
        constructor=huawei,
        command_text="display lldp neighbor brief",
        example="display lldp neighbor brief",
        notes="Liste des voisins LLDP"
    )
    CommandVariant.objects.create(
        action=action_neighbors,
        constructor=fortinet,
        command_text="get system lldp neighbors",
        example="get system lldp neighbors",
        notes="Voisins découverts via LLDP"
    )
    CommandVariant.objects.create(
        action=action_neighbors,
        constructor=mikrotik,
        command_text="interface ethernet monitor lldp",
        example="interface ethernet monitor lldp once",
        notes="Affiche les voisins LLDP"
    )

# Action: Afficher les statistiques DHCP 
action_dhcp_stats, created = CommandAction.objects.get_or_create(
    title="Afficher les statistiques DHCP",
    defaults={
        'category': 'management',
        'description': "Affiche les statistiques du serveur DHCP"
    }
)

if created:
    # Variantes DHCP (uniquement si l'action est nouvelle)
    CommandVariant.objects.create(
        action=action_dhcp_stats,
        constructor=cisco,
        command_text="show ip dhcp statistics",
        example="show ip dhcp statistics",
        notes="Statistiques du serveur DHCP"
    )
    CommandVariant.objects.create(
        action=action_dhcp_stats,
        constructor=juniper,
        command_text="show dhcp statistics",
        example="show dhcp statistics",
        notes="Statistiques DHCP globales"
    )
    CommandVariant.objects.create(
        action=action_dhcp_stats,
        constructor=huawei,
        command_text="display dhcp statistics",
        example="display dhcp statistics",
        notes="Statistiques du service DHCP"
    )
    CommandVariant.objects.create(
        action=action_dhcp_stats,
        constructor=fortinet,
        command_text="get system dhcp statistics",
        example="get system dhcp statistics",
        notes="Métriques du serveur DHCP"
    )
    CommandVariant.objects.create(
        action=action_dhcp_stats,
        constructor=mikrotik,
        command_text="ip dhcp-server print stats",
        example="ip dhcp-server print stats",
        notes="Statistiques des baux DHCP"
    )


#####################################################################

# --- Table CommandVariant ---


# Action: Afficher la table de routage IPv6 
action_ipv6_route, created = CommandAction.objects.get_or_create(
    title="Afficher la table de routage IPv6",
    defaults={
        'category': 'routing',
        'description': "Affiche les routes IPv6 actives dans la table de routage"
    }
)

if created:
    # Variantes IPv6 Routing
    CommandVariant.objects.create(
        action=action_ipv6_route,
        constructor=cisco,
        command_text="show ipv6 route",
        example="show ipv6 route",
        notes="Affiche toutes les routes IPv6"
    )
    CommandVariant.objects.create(
        action=action_ipv6_route,
        constructor=juniper,
        command_text="show ipv6 route",
        example="show ipv6 route",
        notes="Routes IPv6 avec protocoles"
    )
    CommandVariant.objects.create(
        action=action_ipv6_route,
        constructor=huawei,
        command_text="display ipv6 routing-table",
        example="display ipv6 routing-table",
        notes="Table de routage IPv6 complète"
    )
    CommandVariant.objects.create(
        action=action_ipv6_route,
        constructor=fortinet,
        command_text="get router info ipv6-routing-table",
        example="get router info ipv6-routing-table",
        notes="Routes IPv6 avec métriques"
    )
    CommandVariant.objects.create(
        action=action_ipv6_route,
        constructor=mikrotik,
        command_text="ipv6 route print",
        example="ipv6 route print",
        notes="Liste des routes IPv6 configurées"
    )

# Action: Afficher les interfaces IPv6 
action_ipv6_intf, created = CommandAction.objects.get_or_create(
    title="Afficher les interfaces IPv6",
    defaults={
        'category': 'management',
        'description': "Affiche la configuration et le statut des interfaces IPv6"
    }
)

if created:
    # Variantes Interfaces IPv6
    CommandVariant.objects.create(
        action=action_ipv6_intf,
        constructor=cisco,
        command_text="show ipv6 interface brief",
        example="show ipv6 interface brief",
        notes="Résumé des interfaces IPv6"
    )
    CommandVariant.objects.create(
        action=action_ipv6_intf,
        constructor=juniper,
        command_text="show ipv6 interfaces",
        example="show ipv6 interfaces",
        notes="Détails des interfaces IPv6"
    )
    CommandVariant.objects.create(
        action=action_ipv6_intf,
        constructor=huawei,
        command_text="display ipv6 interface",
        example="display ipv6 interface brief",
        notes="Configuration IPv6 des interfaces"
    )
    CommandVariant.objects.create(
        action=action_ipv6_intf,
        constructor=fortinet,
        command_text="show system ipv6 interfaces",
        example="show system ipv6 interfaces",
        notes="Interfaces avec IPv6 activé"
    )
    CommandVariant.objects.create(
        action=action_ipv6_intf,
        constructor=mikrotik,
        command_text="ipv6 address print",
        example="ipv6 address print",
        notes="Adresses IPv6 configurées"
    )

# Action: Gérer les utilisateurs 
action_users, created = CommandAction.objects.get_or_create(
    title="Gérer les utilisateurs système",
    defaults={
        'category': 'management',
        'description': "Commandes pour afficher et gérer les utilisateurs connectés"
    }
)

if created:
    # Variantes Gestion Utilisateurs
    CommandVariant.objects.create(
        action=action_users,
        constructor=cisco,
        command_text="show users",
        example="show users",
        notes="Liste des sessions utilisateur actives"
    )
    CommandVariant.objects.create(
        action=action_users,
        constructor=juniper,
        command_text="show system users",
        example="show system users",
        notes="Utilisateurs connectés au système"
    )
    CommandVariant.objects.create(
        action=action_users,
        constructor=huawei,
        command_text="display users",
        example="display users",
        notes="Sessions utilisateur en cours"
    )
    CommandVariant.objects.create(
        action=action_users,
        constructor=fortinet,
        command_text="get system session list",
        example="get system session list",
        notes="Liste des sessions actives"
    )
    CommandVariant.objects.create(
        action=action_users,
        constructor=mikrotik,
        command_text="user active print",
        example="user active print",
        notes="Utilisateurs actuellement connectés"
    )

    ########################################################################

    # --- Table CommandVariant ---


# Action: Effectuer un test ping 
action_ping, created = CommandAction.objects.get_or_create(
    title="Effectuer un test ping",
    defaults={
        'category': 'diagnostic',
        'description': "Test de connectivité vers une adresse IP ou un hostname"
    }
)

if created:
    # Variantes Ping
    CommandVariant.objects.create(
        action=action_ping,
        constructor=cisco,
        command_text="ping",
        example="ping 192.168.1.1",
        notes="Appuyer sur Entrée pour les options supplémentaires"
    )
    CommandVariant.objects.create(
        action=action_ping,
        constructor=juniper,
        command_text="ping",
        example="ping 192.168.1.1 count 5",
        notes="Options: count, size, rapid"
    )
    CommandVariant.objects.create(
        action=action_ping,
        constructor=huawei,
        command_text="ping",
        example="ping -c 5 192.168.1.1",
        notes="Option -c pour le nombre de paquets"
    )
    CommandVariant.objects.create(
        action=action_ping,
        constructor=fortinet,
        command_text="execute ping",
        example="execute ping 192.168.1.1",
        notes="Syntaxe différente des autres constructeurs"
    )
    CommandVariant.objects.create(
        action=action_ping,
        constructor=mikrotik,
        command_text="ping",
        example="ping 192.168.1.1 count=5",
        notes="Format: paramètre=valeur"
    )

# Action: Effectuer un traceroute 
action_trace, created = CommandAction.objects.get_or_create(
    title="Effectuer un traceroute",
    defaults={
        'category': 'diagnostic',
        'description': "Trace le chemin vers une destination en identifiant les sauts"
    }
)

if created:
    # Variantes Traceroute
    CommandVariant.objects.create(
        action=action_trace,
        constructor=cisco,
        command_text="traceroute",
        example="traceroute 192.168.1.1",
        notes="Utilise UDP par défaut"
    )
    CommandVariant.objects.create(
        action=action_trace,
        constructor=juniper,
        command_text="traceroute",
        example="traceroute 192.168.1.1",
        notes="Options: wait, no-resolve"
    )
    CommandVariant.objects.create(
        action=action_trace,
        constructor=huawei,
        command_text="tracert",
        example="tracert 192.168.1.1",
        notes="Utilise ICMP par défaut"
    )
    CommandVariant.objects.create(
        action=action_trace,
        constructor=fortinet,
        command_text="execute traceroute",
        example="execute traceroute 192.168.1.1",
        notes="Nécessite le préfixe 'execute'"
    )
    CommandVariant.objects.create(
        action=action_trace,
        constructor=mikrotik,
        command_text="tool traceroute",
        example="tool traceroute 192.168.1.1",
        notes="Nécessite le préfixe 'tool'"
    )

# Action: Sauvegarder la configuration 
action_backup, created = CommandAction.objects.get_or_create(
    title="Sauvegarder la configuration",
    defaults={
        'category': 'management',
        'description': "Enregistre la configuration courante en mémoire ou sur un serveur externe"
    }
)

if created:
    # Variantes Sauvegarde
    CommandVariant.objects.create(
        action=action_backup,
        constructor=cisco,
        command_text="copy running-config startup-config",
        example="copy running-config startup-config",
        notes="Sauvegarde en mémoire non-volatile"
    )
    CommandVariant.objects.create(
        action=action_backup,
        constructor=juniper,
        command_text="commit",
        example="commit and-quit",
        notes="Valide les changements en cours"
    )
    CommandVariant.objects.create(
        action=action_backup,
        constructor=huawei,
        command_text="save",
        example="save",
        notes="Sauvegarde la configuration actuelle"
    )
    CommandVariant.objects.create(
        action=action_backup,
        constructor=fortinet,
        command_text="execute backup config",
        example="execute backup config to tftp://server/backup.conf",
        notes="Permet de sauvegarder sur un serveur externe"
    )
    CommandVariant.objects.create(
        action=action_backup,
        constructor=mikrotik,
        command_text="system backup save",
        example="system backup save name=backup",
        notes="Crée un fichier de sauvegarde"
    )

    ####################################################################"

    # --- Table CommandVariant ---


# Action: Afficher la configuration QoS 
action_qos, created = CommandAction.objects.get_or_create(
    title="Afficher la configuration QoS",
    defaults={
        'category': 'quality_of_service',
        'description': "Affiche les politiques et paramètres de qualité de service"
    }
)

if created:
    # Variantes QoS
    CommandVariant.objects.create(
        action=action_qos,
        constructor=cisco,
        command_text="show policy-map",
        example="show policy-map interface GigabitEthernet0/1",
        notes="Affiche les politiques QoS appliquées"
    )
    CommandVariant.objects.create(
        action=action_qos,
        constructor=juniper,
        command_text="show class-of-service",
        example="show class-of-service interface ge-0/0/0",
        notes="Configuration CoS (Class of Service)"
    )
    CommandVariant.objects.create(
        action=action_qos,
        constructor=huawei,
        command_text="display qos configuration",
        example="display qos configuration interface GigabitEthernet0/0/1",
        notes="Affiche la QoS par interface"
    )
    CommandVariant.objects.create(
        action=action_qos,
        constructor=fortinet,
        command_text="show traffic-shape",
        example="show traffic-shape interface port1",
        notes="Politiques de shaping du trafic"
    )
    CommandVariant.objects.create(
        action=action_qos,
        constructor=mikrotik,
        command_text="queue tree print",
        example="queue tree print",
        notes="Affiche les règles de file d'attente"
    )

# Action: Afficher les statistiques QoS 
action_qos_stats, created = CommandAction.objects.get_or_create(
    title="Afficher les statistiques QoS",
    defaults={
        'category': 'quality_of_service',
        'description': "Montre les statistiques d'application des politiques QoS"
    }
)

if created:
    # Variantes Statistiques QoS
    CommandVariant.objects.create(
        action=action_qos_stats,
        constructor=cisco,
        command_text="show policy-map interface",
        example="show policy-map interface GigabitEthernet0/1",
        notes="Statistiques par interface"
    )
    CommandVariant.objects.create(
        action=action_qos_stats,
        constructor=juniper,
        command_text="show class-of-service statistics",
        example="show class-of-service statistics interface ge-0/0/0",
        notes="Statistiques CoS détaillées"
    )
    CommandVariant.objects.create(
        action=action_qos_stats,
        constructor=huawei,
        command_text="display qos statistics",
        example="display qos statistics interface GigabitEthernet0/0/1",
        notes="Compteurs QoS par interface"
    )
    CommandVariant.objects.create(
        action=action_qos_stats,
        constructor=fortinet,
        command_text="diagnose traffic-shape statistics",
        example="diagnose traffic-shape statistics show",
        notes="Statistiques détaillées de shaping"
    )
    CommandVariant.objects.create(
        action=action_qos_stats,
        constructor=mikrotik,
        command_text="queue monitor",
        example="queue monitor [find name=all]",
        notes="Monitoring des files d'attente en temps réel"
    )

# Action: Configurer le monitoring SNMP 
action_snmp, created = CommandAction.objects.get_or_create(
    title="Configurer le monitoring SNMP",
    defaults={
        'category': 'monitoring',
        'description': "Commandes pour configurer et vérifier le monitoring SNMP"
    }
)

if created:
    # Variantes SNMP
    CommandVariant.objects.create(
        action=action_snmp,
        constructor=cisco,
        command_text="show snmp",
        example="show snmp community",
        notes="Affiche la configuration SNMP"
    )
    CommandVariant.objects.create(
        action=action_snmp,
        constructor=juniper,
        command_text="show snmp statistics",
        example="show snmp statistics",
        notes="Statistiques des requêtes SNMP"
    )
    CommandVariant.objects.create(
        action=action_snmp,
        constructor=huawei,
        command_text="display snmp-agent",
        example="display snmp-agent sys-info",
        notes="Information système SNMP"
    )
    CommandVariant.objects.create(
        action=action_snmp,
        constructor=fortinet,
        command_text="get system snmp",
        example="get system snmp sysinfo",
        notes="Configuration SNMP du système"
    )
    CommandVariant.objects.create(
        action=action_snmp,
        constructor=mikrotik,
        command_text="snmp print",
        example="snmp print",
        notes="Affiche la configuration SNMP"
    )

    #############################################################

    # --- Table CommandVariant ---


# Action: Gérer les VRF (Virtual Routing and Forwarding)
action_vrf, created = CommandAction.objects.get_or_create(
    title="Gérer les VRF",
    defaults={
        'category': 'virtualization',
        'description': "Commandes pour gérer les instances de routage virtuelles (VRF)"
    }
)

if created:
    # Variantes VRF
    CommandVariant.objects.create(
        action=action_vrf,
        constructor=cisco,
        command_text="show vrf",
        example="show vrf detail",
        notes="Affiche toutes les VRF configurées"
    )
    CommandVariant.objects.create(
        action=action_vrf,
        constructor=juniper,
        command_text="show routing-instances",
        example="show routing-instances",
        notes="Équivalent Juniper des VRF"
    )
    CommandVariant.objects.create(
        action=action_vrf,
        constructor=huawei,
        command_text="display ip vpn-instance",
        example="display ip vpn-instance",
        notes="Affiche les instances VPN (VRF)"
    )
    CommandVariant.objects.create(
        action=action_vrf,
        constructor=fortinet,
        command_text="show system vdom",
        example="show system vdom",
        notes="Affiche les VDOM (Virtual Domains)"
    )
    CommandVariant.objects.create(
        action=action_vrf,
        constructor=mikrotik,
        command_text="/routing vrf print",
        example="/routing vrf print",
        notes="Liste des VRF configurées"
    )

# Action: Inspecter les menaces de sécurité
action_threats, created = CommandAction.objects.get_or_create(
    title="Inspecter les menaces de sécurité",
    defaults={
        'category': 'security',
        'description': "Affiche les menaces détectées (IPS, antivirus, etc.)"
    }
)

if created:
    # Variantes Inspection des menaces
    CommandVariant.objects.create(
        action=action_threats,
        constructor=cisco,
        command_text="show ips alerts",
        example="show ips alerts",
        notes="Alertes du système de prévention d'intrusion"
    )
    CommandVariant.objects.create(
        action=action_threats,
        constructor=juniper,
        command_text="show security alerts",
        example="show security alerts",
        notes="Alertes de sécurité globales"
    )
    CommandVariant.objects.create(
        action=action_threats,
        constructor=huawei,
        command_text="display threat-defense statistics",
        example="display threat-defense statistics",
        notes="Statistiques de défense contre les menaces"
    )
    CommandVariant.objects.create(
        action=action_threats,
        constructor=fortinet,
        command_text="get system threat-emulation status",
        example="get system threat-emulation status",
        notes="Statut de l'émulation de menaces"
    )
    CommandVariant.objects.create(
        action=action_threats,
        constructor=mikrotik,
        command_text="tool sniffer packet detect",
        example="tool sniffer packet detect",
        notes="Détection d'anomalies réseau"
    )

# Action: Gérer les certificats SSL
action_certs, created = CommandAction.objects.get_or_create(
    title="Gérer les certificats SSL",
    defaults={
        'category': 'security',
        'description': "Commandes pour gérer les certificats numériques"
    }
)

if created:
    # Variantes Certificats
    CommandVariant.objects.create(
        action=action_certs,
        constructor=cisco,
        command_text="show crypto pki certificates",
        example="show crypto pki certificates",
        notes="Liste des certificats installés"
    )
    CommandVariant.objects.create(
        action=action_certs,
        constructor=juniper,
        command_text="show security pki certificates",
        example="show security pki certificates",
        notes="Certificats PKI du système"
    )
    CommandVariant.objects.create(
        action=action_certs,
        constructor=huawei,
        command_text="display pki certificate",
        example="display pki certificate",
        notes="Affiche les certificats PKI"
    )
    CommandVariant.objects.create(
        action=action_certs,
        constructor=fortinet,
        command_text="get system certificate list",
        example="get system certificate list",
        notes="Liste des certificats système"
    )
    CommandVariant.objects.create(
        action=action_certs,
        constructor=mikrotik,
        command_text="certificate print",
        example="certificate print",
        notes="Affiche les certificats installés"
    )

    ##############################################################

    # --- Table CommandVariant ---

# Action: Vérifier l'état de haute disponibilité 
action_ha, created = CommandAction.objects.get_or_create(
    title="Vérifier l'état de haute disponibilité",
    defaults={
        'category': 'high_availability', 
        'description': "Affiche le statut du cluster HA et la synchronisation entre nœuds"
    }
)

if created:
    # Variantes HA
    CommandVariant.objects.create(
        action=action_ha,
        constructor=cisco,
        command_text="show redundancy",
        example="show redundancy",
        notes="Statut de la redondance sur les routeurs"
    )
    CommandVariant.objects.create(
        action=action_ha,
        constructor=juniper,
        command_text="show chassis cluster status",
        example="show chassis cluster status",
        notes="État du cluster sur les appliances"
    )
    CommandVariant.objects.create(
        action=action_ha,
        constructor=huawei,
        command_text="display hrp state",
        example="display hrp state",
        notes="Statut Huawei Redundancy Protocol"
    )
    CommandVariant.objects.create(
        action=action_ha,
        constructor=fortinet,
        command_text="get system ha status",
        example="get system ha status",
        notes="Détails de l'état HA"
    )
    CommandVariant.objects.create(
        action=action_ha,
        constructor=mikrotik,
        command_text="routing ospf instance print",
        example="routing ospf instance print",
        notes="Vérification des instances pour le HA"
    )

# Action: Gérer les tunnels GRE 
action_gre, created = CommandAction.objects.get_or_create(
    title="Gérer les tunnels GRE",
    defaults={
        'category': 'tunneling',
        'description': "Commandes pour configurer et diagnostiquer les tunnels GRE"
    }
)

if created:
    # Variantes GRE
    CommandVariant.objects.create(
        action=action_gre,
        constructor=cisco,
        command_text="show interface tunnel",
        example="show interface tunnel 0",
        notes="Statut des interfaces tunnel"
    )
    CommandVariant.objects.create(
        action=action_gre,
        constructor=juniper,
        command_text="show interfaces gr-*",
        example="show interfaces gr-0/0/0",
        notes="Interfaces GRE spécifiques"
    )
    CommandVariant.objects.create(
        action=action_gre,
        constructor=huawei,
        command_text="display interface tunnel",
        example="display interface tunnel 0/0/1",
        notes="Affiche la configuration tunnel"
    )
    CommandVariant.objects.create(
        action=action_gre,
        constructor=fortinet,
        command_text="show system gre-tunnel",
        example="show system gre-tunnel",
        notes="Liste des tunnels GRE"
    )
    CommandVariant.objects.create(
        action=action_gre,
        constructor=mikrotik,
        command_text="interface gre print",
        example="interface gre print",
        notes="Affiche les tunnels GRE configurés"
    )

# Action: Capturer des paquets 
action_pcap, created = CommandAction.objects.get_or_create(
    title="Capturer des paquets",
    defaults={
        'category': 'diagnostic',
        'description': "Commandes pour capturer et analyser le trafic réseau"
    }
)

if created:
    # Variantes Capture
    CommandVariant.objects.create(
        action=action_pcap,
        constructor=cisco,
        command_text="monitor capture",
        example="monitor capture CAPTURE interface Gig0/1 both",
        notes="Capture avancée nécessitant configuration"
    )
    CommandVariant.objects.create(
        action=action_pcap,
        constructor=juniper,
        command_text="monitor traffic interface",
        example="monitor traffic interface ge-0/0/0",
        notes="Capture en temps réel"
    )
    CommandVariant.objects.create(
        action=action_pcap,
        constructor=huawei,
        command_text="capture-packet",
        example="capture-packet interface GigabitEthernet 0/0/1",
        notes="Capture vers un fichier"
    )
    CommandVariant.objects.create(
        action=action_pcap,
        constructor=fortinet,
        command_text="diagnose sniffer packet",
        example="diagnose sniffer packet port1 'host 192.168.1.1'",
        notes="Filtrage puissant disponible"
    )
    CommandVariant.objects.create(
        action=action_pcap,
        constructor=mikrotik,
        command_text="tool sniffer quick",
        example="tool sniffer quick interface=ether1",
        notes="Capture rapide avec filtres"
    )

    ###############################################################"

    # --- Table CommandVariant ---
# Bloc 11 (Commandes 201-220) - Commandes avancées

# Action: Manipuler les attributs BGP 
action_bgp_attr, created = CommandAction.objects.get_or_create(
    title="Manipuler les attributs BGP",
    defaults={
        'category': 'routing',
        'description': "Commandes pour modifier les attributs BGP (AS Path, Local Pref, etc.)"
    }
)

if created:
    # Variantes BGP Attributes
    bgp_attr_commands = [
        (cisco, "show bgp neighbors 192.168.1.1 received-routes", "Affiche les routes reçues avec attributs"),
        (juniper, "show route receive-protocol bgp 192.168.1.1", "Routes reçues d'un voisin spécifique"),
        (huawei, "display bgp routing-table peer 192.168.1.1 received-routes", "Routes BGP reçues"),
        (fortinet, "get router info bgp neighbors 192.168.1.1 received-routes", "Détail des routes reçues"),
        (mikrotik, "routing bgp advertisements print", "Affiche les annonces BGP")
    ]
    for constructor, cmd, notes in bgp_attr_commands:
        CommandVariant.objects.create(
            action=action_bgp_attr,
            constructor=constructor,
            command_text=cmd,
            example=cmd,
            notes=notes
        )

# Action: Gérer le multicast PIM 
action_pim, created = CommandAction.objects.get_or_create(
    title="Gérer le multicast PIM",
    defaults={
        'category': 'multicast', 
        'description': "Commandes pour le Protocol Independent Multicast"
    }
)

if created:
    # Variantes PIM
    pim_commands = [
        (cisco, "show ip pim neighbor", "Liste des voisins PIM"),
        (juniper, "show pim neighbors", "Voisins PIM avec détails"),
        (huawei, "display pim neighbor", "Table des voisins PIM"),
        (fortinet, "show router pim neighbor", "Voisinages PIM"),
        (mikrotik, "routing pimsm print neighbor", "Affiche les voisins PIM-SM")
    ]
    for constructor, cmd, notes in pim_commands:
        CommandVariant.objects.create(
            action=action_pim,
            constructor=constructor,
            command_text=cmd,
            example=cmd,
            notes=notes
        )

# Action: Configurer IGMP Snooping 
action_igmp_snoop, created = CommandAction.objects.get_or_create(
    title="Configurer IGMP Snooping",
    defaults={
        'category': 'multicast',
        'description': "Commandes pour gérer le snooping IGMP sur les switches"
    }
)

if created:
    # Variantes IGMP Snooping
    igmp_commands = [
        (cisco, "show ip igmp snooping", "Statut global du snooping"),
        (juniper, "show igmp snooping", "Configuration et statut"),
        (huawei, "display igmp-snooping", "Table de snooping"),
        (fortinet, "show system igmp-snooping", "Statut par VLAN"),
        (mikrotik, "interface bridge mdb print", "Affiche la table multicast")
    ]
    for constructor, cmd, notes in igmp_commands:
        CommandVariant.objects.create(
            action=action_igmp_snoop,
            constructor=constructor,
            command_text=cmd,
            example=cmd,
            notes=notes
        )