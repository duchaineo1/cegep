# Projet de veille 
- [Projet de veille](#projet-de-veille)
  * [Pré-requis](#pré-requis)
  * [Installation de Kubernetes](#installation-de-kubernetes)
  * [Installation de Jenkins sur Kubernetes](#installation-de-jenkins-sur-kubernetes)
  * [Authentification](#authentification)
  * [Création d'un pipeline](#pipeline)
## Pré-requis

- Deux machines virtuelles Ubuntu 18.04 Desktop ou serveur. (2 cpu 4gb de ram)
- L'une des deux machines sera désigné comme master et l'autre comme worker. 

## Installation de Kubernetes
(Les étapes 1 à 5 sont à faire sur chacune des machines)
1. **Mettre les deux machines à jour**

```bash
sudo apt-get update && sudo apt-get upgrade -y
```

2. **Installation de Docker, on démarre le service et on s'assure qu'il redémarre si notre node redémarre.**

```bash
sudo apt-get install -y docker.io
sudo systemctl enable docker
sudo systemctl start docker
sudo systemctl status docker # On peut vérifier le status du service pour être certain
```
3. **Installation CURL et Kubernetes**

```bash
sudo apt-get install -y curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add
sudo apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"
sudo apt-get install -y kubeadm kubelet kubectl
sudo apt-mark hold kubeadm kubelet kubectl # On stop les MAJ automatique de ces services 
kubeadm version # À titre informatif pour s'assurer que la commande est fonctionnelle. 
```

4. **Désactivation du swap de mémoire.**

Avec votre éditeur favoris (vim) il faut commenter la ligne qui mentionne le swap dans /etc/fstab. 
Redémarrage mandatoire. 

5. **Mettre un hostname unique sur vos machines.**

```bash
sudo hostnamectl set-hostname un_nom_unique
```

6. **SUR LE MASTER UNIQUEMENT. Initialisation du network.**

```bash
sudo kubeadm init --pod-network-cidr=10.244.0.0/16 # À la conclusion de la commande une string nous est fournis, à garder. 
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
sudo kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml # Ces pods vont s'occuper du networking entre nos nodes/pods
kubectl get pods --all-namespaces # Vous devriez voir les pods que vous venez de créer en création
```
7. **SUR LE WORKER UNIQUEMENT. On join notre worker au cluster.**

Avec la string qu'on a préservé : 

```bash
kubeadm join --discovery-token abcdef.1234567890abcdef --discovery-token-ca-cert-hash sha256:1234..cdef 1.2.3.4:6443
```

De retour sur le master on vérifie que le join a fonctionné :

```bash
kubectl get nodes # On devrait voir le worker node. Son status passera à ready après quelques dizaines de secondes
```

## Installation de Jenkins sur Kubernetes

Pour s'assurer que notre montage est performant et qu'il est simple de déployer sur Kubernetes on utilise un service Jenkins. On l'incorpore dans notre cluster pour lui donner une haute disponibilité. 

1. **Clonez le dépôt.**

```bash
git clone https://github.com/duchaineo1/cegep.git
```

2. **Création du namespace pour Jenkins**

```bash
kubectl create ns jenkins 
```

3. **Application des fichiers .yml**

```bash
cd cegep
kubectl -n jenkins apply -f ./jenkins/ # patientez 
kubectl get pods -n jenkins # Devrais vous donnez le nom du pod qui a été produit 
```

4. **Récupération du mot de passe admin de Jenkins**

```bash
kubectl -n jenkins logs nom_de_ton_pod # Le mot de passe est dans ce log 
```

Une fois le mot de passe récupéré on peut accéder à Jenkins à partir de l'url de ton worker node. 
Ex: http://192.168.1.1:8080

5. **Faire la configuration de base de Jenkins**

- Install suggested plugins 
- Créer un utilisateur avec un mot de passe 

6. **Installation de plugins**

Une fois la configuration de base complété : 

- Manage Jenkins -> Manage Plugins -> Available

On a besoin de deux plugins pour ce montage : Kubernetes et Kubernetes continuous deploy 

**C'est possible que vous ayez à rafraichir manuellement la page**

Une fois l'installation terminé il faudra redémmarer Jenkins, juste à cocher la case en bas. 

7. **Configuration du cloud**

Après le rédémarrage 

- Manage Jenkins -> Manage Nodes and Clouds -> Configure Clouds -> Add a new cloud -> Kubernetes 

La configuration du cloud a plusieurs valeurs à entrer, suivre la capture d'écran. 

![kube_cloud_config](https://github.com/duchaineo1/cegep/blob/master/image/Kube_cloud.png?raw=true)

Pour Pods Labels : 

- Key = jenkins 
- Value = slave 

8. **On configure le pod et le container de l'agent Jenkins**

![pod_container_config](https://github.com/duchaineo1/cegep/blob/master/image/pod_container.png?raw=true)

 - Global credentials -> 

9. **Volumes et Service Account**

- Host Path = /var/run/docker.sock
- Mount Path = /var/run/docker.sock
- Service Account = jenkins

On sauvegarde ! 

## Authentification 

1. **Creation de credentials**

Pour que l'agent Jenkins puisse déployer des pods sur notre cluster il doit pouvoir s'identifier. 

- Manage Jenkins -> Manage Credentials 

![pod_container_config](https://github.com/duchaineo1/cegep/blob/master/image/credentials_config1.png?raw=true)

 - Global credentials -> Add credentials 
 
 Le fichier dont on doit copier le contenu se trouve sur le node master.
 
 ```bash
 sudo cat /etc/kubernetes/admin.conf
 ```
 Copiez le contenu dans le champ "content".

![pod_container_config](https://github.com/duchaineo1/cegep/blob/master/image/kubeconfig.png?raw=true)


## Création d'un pipeline <a name="pipeline"></a>

1. **Création du pipeline**

- New Item (sur le menu principal)
- Sélectionne Pipeline et nomme le projet 

![pod_container_config](https://github.com/duchaineo1/cegep/blob/master/image/pipeline_config.png?raw=true)

Si le dépôt est privé on devras créer des credentials de type "Username and password" pour que l'agent Jenkins puisse accéder au dépôt. 

Le script path est important puisque Jenkins a besoin du Jenkinsfile pour savoir quoi faire. 

On peut maintenant Build le pipeline et Jenkins va déployer un serveur web nginx qui devrait être disponible à l'adresse ip de votre worker node. ex: http://192.168.1.1:80 


