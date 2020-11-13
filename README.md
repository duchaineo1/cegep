# Projet de veille 

## Pré-requis

- Deux machines virtuelles Ubuntu 18.04 Desktop ou serveur. 
- L'une des deux machines sera désigné comme master et l'autre comme slave. 
- À moins que ce soit spécifié les commandes doivent être exécuté sur chacune des machines. 

## Instalation
1. Mettre les deux machines à jour

```bash
sudo apt-get update && sudo apt-get upgrade
```

2. Installation de docker, on part le service et on le part après un redémmarage

```bash
sudo apt-get install -y docker.io
sudo systemctl enable docker
sudo systemctl start docker
sudo systemctl status docker # On peut vérifier le status du service pour être certain
```
3. Installation CURL et kubernetes

```bash
sudo apt-get install -y curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add
sudo apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"
sudo apt-get install -y kubeadm kubelet kubectl
sudo apt-mark hold kubeadm kubelet kubectl # On stop les MAJ automatique de ces services 
kubeadm version # À titre informatif pour s'assurer que la commande est fonctionnelle. 
```

4. Désactivation du swap de mémoire. 

Avec votre éditeur favoris (vim) il faut commenter la ligne qui mentionne le swap dans /etc/fstab. Redémarrage mandatoire. 

5. Mettre un hostname unique sur vos machines. 

```bash
sudo hostnamectl set-hostname un_nom_unique
```

6. SUR LE MASTER UNIQUEMENT. 

```bash
sudo kubeadm init --pod-network-cidr=10.244.0.0/16 # On donne le range d'ip de nos pods
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
sudo kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml # Ces pods vont s'occuper du networking entre nos nodes/pods
kubectl get pods --all-namespaces # Vous devriez voir les pods que vous venez de créer en création
```

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.


