# Implementacion de Cluster Kubernate (K8s) prueba de ingreso

Este ejemplo nos permitira Instalar Kubernate y configurar dos cluster con el motor de contenedores Docker el primer cluster servira para los deployments y el segundo cluster sera para los desarrollos
Se debera desplegar un microservicio con java 16
El codigo del microservicio debera estar en un repositorio publico 

**NOTA:** este ejemplo se realizo en una computadora con sistema operativo windows 11
**NOTA:** se ha realizado la implementacion IaC tanto con K8s y Terraform por eso se encuentran ambas carpetas en sus respectivas secciones

Para esta actividad se siguieron los siguientes pasos 

**Instalación de k8s (minikube):**

- En la maquina ya contabamos con Docker Desktop por lo que ya teniamos instalado por default docker y kubectl

- se descargo el ejecutable de minikube para windows desde la siguiente direccion 
[Minikube] (https://minikube.sigs.k8s.io/docs/)
[Instalador de Minikube] (https://github.com/kubernetes/minikube/releases/latest/download/minikube-installer.exe)

**Creación del microservicio en Spring:**

- [Microservicio] (https://github.com/emejia1/sisa-services)

**Creacion de Imagenes:**

- se creo la imagen del Jenkins

- se creo la imagen del SonarKube

- se creo la imagen del microservicio

- Iniciamos Minukube para verificar el funcionamiento

	```console
    PS > minikube start
   
	* minikube v1.26.1 en Microsoft Windows 11 Home Single Language 10.0.22000 Build 22000
	* Using the docker driver based on existing profile
	* Starting control plane node minikube in cluster minikube
	* Pulling base image ...
	* Updating the running docker "minikube" container ...
	* Preparando Kubernetes v1.24.3 en Docker 20.10.17...
	* Verifying Kubernetes components...
	  - Using image kubernetesui/dashboard:v2.6.0
	  - Using image gcr.io/k8s-minikube/storage-provisioner:v5
	  - Using image kubernetesui/metrics-scraper:v1.0.8
	* Complementos habilitados: default-storageclass, storage-provisioner, dashboard
	* Done! kubectl is now configured to use "minikube" cluster and "default" namespace by default
    ```
	
- verificamos los profile exitentes

	```console
    $ minikube profile list
   
	|----------|-----------|---------|--------------|------|---------|---------|-------|--------|
	| Profile  | VM Driver | Runtime |      IP      | Port | Version | Status  | Nodes | Active |
	|----------|-----------|---------|--------------|------|---------|---------|-------|--------|
	| minikube | docker    | docker  | 192.168.49.2 | 8443 | v1.24.3 | Unknown |     1 | *      |
	|----------|-----------|---------|--------------|------|---------|---------|-------|--------|
    ```


- crear 

#### **Did you find a bug?**