import { useState, useEffect, useRef } from 'react';
import axios from 'axios';
import { motion, AnimatePresence } from 'framer-motion';
import { FiChevronDown, FiLoader, FiCheck, FiX, FiCopy, FiUpload, FiTerminal, FiSave, FiSettings, FiTrash2 } from 'react-icons/fi';

const CommandTranslator = () => {
  const [command, setCommand] = useState('');
  const [constructors, setConstructors] = useState([]);
  const [selectedConstructor, setSelectedConstructor] = useState('');
  const [translatedCommand, setTranslatedCommand] = useState('');
  const [isLoading, setIsLoading] = useState(false);
  const [error, setError] = useState(null);
  const [commandHistory, setCommandHistory] = useState([]);
  const [showModal, setShowModal] = useState(false);
  const [deviceInfo, setDeviceInfo] = useState({
    ip: '',
    username: '',
    // sshKey: '',
    password: '',
    port: '22',
    type: ''
  });
  const [suggestions, setSuggestions] = useState([]);
  const [selectedSuggestionIndex, setSelectedSuggestionIndex] = useState(0);
  const [commonCommands, setCommonCommands] = useState([
    'show running-config',
    'show interfaces',
    'show ip route',
    'show version',
    'configure terminal',
    'show vlan',
    'show cdp neighbors',
    'show ip interfaces brief',
    'show spanning-tree',
    'show mac address-table'
  ]);
  const inputRef = useRef(null);

  useEffect(() => {
    const fetchConstructors = async () => {
      try {
        const response = await axios.get('/api/constructors/');
        setConstructors(response.data);
        if (response.data.length > 0) {
          setSelectedConstructor(response.data[0].id);
        }
      } catch {
        setError('Échec du chargement des constructeurs');
      }
    };
    fetchConstructors();
  }, []);

  useEffect(() => {
    const translate = async () => {
      if (command.length > 2 && selectedConstructor) {
        setIsLoading(true);
        setError(null);
        try {
          const response = await axios.post('/api/translate/', {
            command,
            constructor_id: selectedConstructor
          });
          setTranslatedCommand(response.data.translated_command);
        } catch (err) {
          setError(err.response?.data?.error || 'Échec de la traduction');
        } finally {
          setIsLoading(false);
        }
      }
    };

    const timer = setTimeout(translate, 600);
    return () => clearTimeout(timer);
  }, [command, selectedConstructor]);

  const copyToClipboard = () => {
    navigator.clipboard.writeText(translatedCommand);
  };

  const handleKeyPress = async (e) => {
    if (e.key === 'Enter' && command) {
      e.preventDefault();
      setIsLoading(true);
      try {
        const response = await axios.post('/api/translate/', {
          command,
          constructor_id: selectedConstructor
        });
        setCommandHistory(prev => [...prev, {
          original: command,
          translated: response.data.translated_command,
          timestamp: new Date().toISOString()
        }]);
        setCommand('');
        setTranslatedCommand(response.data.translated_command);
      } catch (err) {
        setError(err.response?.data?.error || 'Échec de la traduction');
      } finally {
        setIsLoading(false);
      }
    }
  };

  const handleUpload = async () => {
    try {
      const deploymentData = {
        device: {...deviceInfo },
        commands: commandHistory.map(cmd => cmd.translated)
        }; m
      console.log("voici mes commandes", deploymentData.device.commands);
      console.log("voici mes commandes History", commandHistory);
      console.log("voici mon deployment data", deploymentData);

      setIsLoading(true);
      const response = await axios.post('/api/deploy/', deploymentData);
      setIsLoading(false)
      if (response.data.success) {
        alert('Déploiement réussi !');
      }
      setShowModal(false);
    }
      catch (err) {
      setError(err.response?.data?.error || 'Échec du déploiement');
      alert('Erreur lors du déploiement: ' + err.message);
    }
  };

  const clearTerminal = () => {
    setCommandHistory([]);
  };

  // Fonction pour filtrer les suggestions
  const filterSuggestions = (input) => {
    if (!input) {
      setSuggestions([]);
      setSelectedSuggestionIndex(0);
      return;
    };
    const filtered = commonCommands.filter(cmd => 
      cmd.toLowerCase().startsWith(input.toLowerCase())
    );
    setSuggestions(filtered);
    setSelectedSuggestionIndex(0);
  };

  // Gestion des touches spéciales
  const handleKeyDown = (e) => {
    if (e.key === 'Tab' && suggestions.length > 0) {
      e.preventDefault();
      setCommand(suggestions[selectedSuggestionIndex]);
      setSuggestions([]);
    } else if (e.key === 'ArrowDown') {
      e.preventDefault();
      setSelectedSuggestionIndex(prev => 
        prev < suggestions.length - 1 ? prev + 1 : prev
      );
    } else if (e.key === 'ArrowUp') {
      e.preventDefault();
      setSelectedSuggestionIndex(prev => prev > 0 ? prev - 1 : prev);
    }
  };

  // Modification du handleChange de l'input
  const handleInputChange = (e) => {
    const value = e.target.value;
    setCommand(value);
    filterSuggestions(value);
  };

  return (
    <div className="min-h-screen bg-[#0f172a]">
      {/* Navigation */}
      <nav className="bg-[#1e293b] border-b border-[#334155]">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="flex items-center justify-between h-16">
            <div className="flex items-center">
              <FiTerminal className="mr-0.1 text-3xl" />
              <span className="ml-2 text-xl font-semibold text-cyan-400">Serigne Malick Sawadogo ❤️</span>
            </div>
            <div className="flex items-center space-x-4">
              <button className="bg-cyan-600 hover:bg-cyan-700 px-4 py-2 rounded-lg flex items-center">
                <FiSave className="mr-2" />
                Sauvegarder Session
              </button>
              <button className="bg-cyan-600 hover:bg-cyan-700 px-4 py-2 rounded-lg flex items-center">
                <FiSettings className="mr-2" />
                Paramètres
              </button>
            </div>
          </div>
        </div>
      </nav>

      {/* contenu principal */}
      <div className="max-w-7xl mx-auto py-6 px-4 sm:px-6 lg:px-8 ">
        <div className="grid grid-cols-1 lg:grid-cols-5 gap-6">
          <div className="lg:col-span-1 bg-[#1e293b] rounded-lg p-4 space-y-4">
            <h2 className="text-lg font-semibold text-cyan-400 mb-4">Constructeurs</h2>
            <div className="space-y-2">
              {constructors.map(cons => (
                <button
                  key={cons.id}
                  onClick={() => setSelectedConstructor(cons.id)}
                  className={`
                    w-full text-left px-3 py-2 rounded 
                    transition-all duration-300 ease-in-out
                    border-2 
                    ${
                      selectedConstructor === cons.id 
                        ? 'bg-cyan-600/20 text-white border-cyan-400 shadow-lg shadow-cyan-500/20 transform translate-x-1'
                        : 'text-gray-300 hover:bg-[#2d3748] border-transparent hover:border-cyan-400/50'
                    }
                    hover:scale-[1.02]
                    focus:outline-none focus:ring-2 focus:ring-cyan-400/50
                  `}
                >
                  <div className="flex items-center">
                    {selectedConstructor === cons.id && (
                      <div className="w-2 h-2 bg-cyan-400 rounded-full mr-2 animate-pulse" />
                    )}
                    {cons.name}
                  </div>
                </button>
              ))}
            </div>
            
            {/* <h2 className="text-lg font-semibold text-cyan-400 mt-8 mb-4">Commandes Rapides</h2>
            <div className="space-y-2">
              <button className="w-full text-left px-3 py-2 rounded text-gray-300 hover:bg-[#2d3748]">
                show running-config
              </button>
              <button className="w-full text-left px-3 py-2 rounded text-gray-300 hover:bg-[#2d3748]">
                show interfaces
              </button>
            </div> */}
          </div>

          {/* Partie contenu et transcription */}
          <div className="lg:col-span-2 bg-[#1e293b] rounded-lg p-4">
            <div className="mb-6">
              <div className="relative">
                <input
                  ref={inputRef}
                  type="text"
                  value={command}
                  onChange={handleInputChange}
                  onKeyDown={handleKeyDown}
                  onKeyPress={handleKeyPress}
                  placeholder="Entrez votre commande..."
                  className="w-full bg-[#0f172a] border-2 border-[#334155] rounded-lg px-4 py-3 text-white placeholder-gray-500 focus:outline-none focus:border-cyan-500"
                />
                {suggestions.length > 0 && (
                  <div className="absolute w-full mt-1 bg-[#1e293b] border border-[#334155] rounded-lg shadow-lg z-50">
                    {suggestions.map((suggestion, index) => (
                      <div
                        key={suggestion}
                        onClick={() => {
                          setCommand(suggestion);
                          setSuggestions([]);
                        }}
                        className={`px-4 py-2 cursor-pointer ${
                          index === selectedSuggestionIndex
                            ? 'bg-cyan-600 text-white'
                            : 'text-gray-300 hover:bg-[#2d3748]'
                        }`}
                      >
                        {suggestion}
                      </div>
                    ))}
                  </div>
                )}
                <div className="absolute right-2 top-2 flex space-x-2">
                  {command && (
                    <button
                      onClick={() => {
                        setCommand('');
                        setSuggestions([]);
                      }}
                      className="p-1 hover:bg-[#2d3748] rounded"
                    >
                      <FiX className="text-gray-400" />
                    </button>
                  )}
                </div>
              </div>
            </div>

            {/* Affiche les commandes traduites si le champ de saisie n'est pas vide */}
            {command && translatedCommand && (
              <div className="bg-[#0f172a] border border-[#334155] rounded-lg">
                <div className="flex items-center justify-between px-4 py-2 border-b border-[#334155]">
                  <span className="text-cyan-400">Commande Traduite</span>
                  <div className="flex items-center space-x-2">
                    <button 
                      onClick={copyToClipboard}
                      className="text-gray-400 hover:text-white p-1"
                    >
                      <FiCopy />
                    </button>
                  </div>
                </div>
                <pre className="p-4 text-white font-mono text-sm overflow-x-auto">
                  {translatedCommand}
                </pre>
              </div>
            )}
          </div>

          {/* Partie pour notre terminal */}
          <div className="lg:col-span-2 bg-[#1e293b] rounded-lg p-4">
            <div className="flex items-center justify-between mb-4">
              <h2 className="text-lg font-semibold text-cyan-400 flex items-center"><FiTerminal className="mr-1" /><span className='mb-1'>Terminal</span></h2>
              <div className="flex items-center space-x-2">
                <button
                  onClick={clearTerminal}
                  className="px-3 py-1 text-sm text-red-400 hover:text-red-300"
                >
                  <FiTrash2 className="inline mr-1" />
                  Clear
                </button>
                <button
                  onClick={() => setShowModal(true)}
                  className="px-3 py-1 text-sm text-cyan-400 hover:text-cyan-300"
                >
                  <FiUpload className="inline mr-1" />
                  Deploy
                </button>
              </div>
            </div>
            <div className="bg-[#0f172a] rounded-lg p-4 h-[calc(100vh-300px)] overflow-y-auto font-mono text-sm">
              {commandHistory.map((cmd, index) => (
                <div key={index} className="mb-4">
                  <div className="flex items-center text-gray-500 mb-1">
                    <FiTerminal className="mr-2" />
                    <span className="text-xs">{new Date(cmd.timestamp).toLocaleTimeString()}</span>
                  </div>
                  <div className="text-gray-400 ml-6">{`> ${cmd.original}`}</div>
                  <div className="text-cyan-400 ml-6">{cmd.translated}</div>
                </div>
              ))}
            </div>
          </div>
        </div>
      </div>

      {/* Modal pour les informations de l'équipement */}
      <AnimatePresence>
        {showModal && (
          <motion.div
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            exit={{ opacity: 0 }}
            className="fixed inset-0 bg-black/50 flex items-center justify-center p-4"
          >
            <motion.div
              initial={{ scale: 0.95 }}
              animate={{ scale: 1 }}
              exit={{ scale: 0.95 }}
              className="bg-[#1e293b] rounded-xl p-6 max-w-md w-full"
            >
              <h2 className="text-xl font-semibold mb-4">Informations de l'équipement</h2>
              <div className="space-y-4">
                <input
                  type="text"
                  placeholder="Adresse IP"
                  value={deviceInfo.ip}
                  onChange={(e) => setDeviceInfo({...deviceInfo, ip: e.target.value})}
                  className="w-full bg-[#0f172a] border border-[#334155] rounded-lg px-4 py-2"
                />
                <input
                  type="text"
                  placeholder="Nom d'utilisateur"
                  value={deviceInfo.username}
                  onChange={(e) => setDeviceInfo({...deviceInfo, username: e.target.value})}
                  className="w-full bg-[#0f172a] border border-[#334155] rounded-lg px-4 py-2"
                />
                <input
                  type="password"
                  placeholder="Mot de passe"
                  value={deviceInfo.password}
                  onChange={(e) => setDeviceInfo({...deviceInfo, password: e.target.value})}
                  className="w-full bg-[#0f172a] border border-[#334155] rounded-lg px-4 py-2"
                />
                {/* <input
                  type="text"
                  placeholder="Clé SSH"
                  value={deviceInfo.sshKey}
                  onChange={(e) => setDeviceInfo({...deviceInfo, sshKey: e.target.value})}
                  className="w-full bg-[#0f172a] border border-[#334155] rounded-lg px-4 py-2"
                /> */}
                <input
                  type="text"
                  placeholder="Port SSH"
                  value={deviceInfo.port}
                  onChange={(e) => setDeviceInfo({...deviceInfo, port: e.target.value})}
                  className="w-full bg-[#0f172a] border border-[#334155] rounded-lg px-4 py-2"
                />
                <select value={deviceInfo.type} onChange={(e) => setDeviceInfo({...deviceInfo, type: e.target.value })} 
                required
                className='w-full bg-[#0f172a] border border-[#334155] rounded-lg px-4 py-2 '
                >
                  <option value="" disabled>Choisir le type</option>
                  <option value="cisco">Cisco</option>
                  <option value="huawei">Huawei</option>
                </select>
                <div className="flex justify-end space-x-4 mt-6">
                  <button
                    onClick={() => { 
                      setShowModal(false);
                      setDeviceInfo({
                        ip: '',
                        username: '',
                        password: '',
                        port: '22'
                      });
                     }}
                    className="px-4 py-2 text-gray-400 hover:text-white"
                  >
                    Annuler
                  </button>
                  <button
                    onClick={handleUpload}
                    className="bg-cyan-600 hover:bg-cyan-700 px-4 py-2 rounded-lg"
                  >
                    Téléverser
                  </button>
                </div>
              </div>
            </motion.div>
          </motion.div>
        )}
      </AnimatePresence>
    </div>
  );
};

export default CommandTranslator;
