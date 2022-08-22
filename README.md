# Implementacion de Cluster Kubernate (K8s) prueba de ingreso

Este ejemplo nos permitira Instalar Kubernate y configurar dos cluster con el motor de contenedores Docker el primer cluster servira para los deployments y el segundo cluster sera para los desarrollos
Se debera desplegar un microservicio con java 16
El codigo del microservicio debera estar en un repositorio publico 

**NOTA:** este ejemplo se realizo en una computadora con sistema operativo windows 11
**NOTA:** se ha realizado la implementacion IaC tanto con K8s y Terraform por eso se encuentran ambas carpetas en sus respectivas secciones

Para esta actividad se siguieron los siguientes pasos 

## **Instalación de k8s (minikube):**

**NOTA:** Se realizaron los pasos de la instalacion segun la documento oficial de cada producto instalado

- En la maquina ya contabamos con Docker Desktop por lo que ya teniamos instalado por default docker y kubectl

- se descargo el ejecutable de minikube para windows desde la siguiente direccion 
[Minikube] (https://minikube.sigs.k8s.io/docs/)
[Instalador de Minikube] (https://github.com/kubernetes/minikube/releases/latest/download/minikube-installer.exe)

**Creación del microservicio en Spring:**

- [Microservicio] (https://github.com/emejia1/sisa-services)

## **Creacion de Imagenes:**

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
	
	
- se realiza la ejecucion de los siguientes comandos para que nuestras acciones en la consola se ejeucten dentro de minikube

	```console
	PS> minikube docker-env
	PS> minikube -p minikube docker-env --shell powershell | Invoke-Expression
	```
- se creo la imagen del Jenkins

Este paso se realiza desde la carpeta [image-jenkins] (https://github.com/emejia1/sisa/tree/main/docker-projects/image-jenkins) desde aca se ejecuta el siguiente comando

	```console
    $ docker build -t jenkins-blue:0.0.1 --no-cache .
	Sending build context to Docker daemon  2.048kB
	Step 1/11 : FROM jenkinsci/blueocean
	 ---> 6aa7e6ae5876
	Step 2/11 : USER root
	 ---> Running in 37c11fe79f31
	Removing intermediate container 37c11fe79f31
	 ---> e0710f2ebfe2
	Step 3/11 : RUN apk update && apk add wget
	 ---> Running in db0bc8972937
	fetch https://dl-cdn.alpinelinux.org/alpine/v3.16/main/x86_64/APKINDEX.tar.gz
	fetch https://dl-cdn.alpinelinux.org/alpine/v3.16/community/x86_64/APKINDEX.tar.gz
	v3.16.2-68-gee69069a4a [https://dl-cdn.alpinelinux.org/alpine/v3.16/main]
	v3.16.2-71-g85f66be967 [https://dl-cdn.alpinelinux.org/alpine/v3.16/community]
	OK: 17057 distinct packages available
	(1/2) Installing libidn2 (2.3.2-r2)
	(2/2) Installing wget (1.21.3-r0)
	Executing busybox-1.35.0-r13.trigger
	OK: 298 MiB in 91 packages
	Removing intermediate container db0bc8972937
	 ---> 4828d46cedee
	Step 4/11 : RUN  wget --no-verbose -O /tmp/apache-maven-3.6.3-bin.tar.gz https://downloads.apache.org/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz
	 ---> Running in b5d5b9d04a9d
	2022-08-22 01:48:11 URL:https://downloads.apache.org/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz [9506321/9506321] -> "/tmp/apache-maven-3.6.3-bin.tar.gz" [1]
	Removing intermediate container b5d5b9d04a9d
	 ---> 2369d7d04785
	Step 5/11 : RUN tar xzf /tmp/apache-maven-3.6.3-bin.tar.gz -C /opt/
	 ---> Running in 3d9e09e4a3e2
	Removing intermediate container 3d9e09e4a3e2
	 ---> dfa2d279f251
	Step 6/11 : RUN ln -s  /opt/apache-maven-3.6.3 /opt/maven
	 ---> Running in 997cb4c540fa
	Removing intermediate container 997cb4c540fa
	 ---> a8daee3b90c9
	Step 7/11 : RUN ln -s /opt/maven/bin/mvn /usr/local/bin
	 ---> Running in 468404a0f1ed
	Removing intermediate container 468404a0f1ed
	 ---> 1ba9f118b01d
	Step 8/11 : RUN rm /tmp/apache-maven-3.6.3-bin.tar.gz
	 ---> Running in ad3b4f5075bc
	Removing intermediate container ad3b4f5075bc
	 ---> 41eb754c2aa0
	Step 9/11 : RUN chown jenkins:jenkins /opt/maven;
	 ---> Running in dec1f44793f0
	Removing intermediate container dec1f44793f0
	 ---> a90c3f3c2062
	Step 10/11 : ENV MAVEN_HOME=/opt/mvn
	 ---> Running in aa65faa0e549
	Removing intermediate container aa65faa0e549
	 ---> 808b07a301e9
	Step 11/11 : USER jenkins
	 ---> Running in 3771821e854b
	Removing intermediate container 3771821e854b
	 ---> a49b1ecd99b0
	Successfully built a49b1ecd99b0
	Successfully tagged jenkins-blue:0.0.1
    ```

- se creo la imagen del SonarQube

Para crear la imagen de SonarQube se hara desde un repositorio del hub de docker por lo que solo se debe ejecutar el siguiente comando

	```console
	PS> docker pull sonarcube
	```

- se creo la imagen del microservicio

Este paso se realiza desde la carpeta [image-service] (https://github.com/emejia1/sisa/tree/main/docker-projects/image-service) desde aca se ejecuta el siguiente comando

	```console
	PS> docker build -t emejia-jdk16:0.0.1 --no-cache --build-arg JAR_FILE=./*.jar .
	```

## **Implementacion de la infraestructura**

**NOTA:** Ambas instalaciones tanto como terraform o k8s contienen las mismas configuraciones por lo que dependiendo del namespace que se tenga en ese momento en kubectl podria dar algun conflicto en cuanto nombres o puertos por lo que se recomienda que si se prueba un ambiente se debe destruir el otro en caso este levantado

**Terraform:**

- Para realizar las acciones debe de ir a cada una de las siguientes carpetas y realizar los pasos posteriores

 Dirigirse a la carpeta [deployment-service\terraform](https://github.com/emejia1/sisa/tree/main/docker-projects/deployment-service/terraform)
 Dirigirse a la carpeta [deployment-devops\terraform] (https://github.com/emejia1/sisa/tree/main/docker-projects/deployment-devops/terraform)

- Iniciar Terraform

	```console
	PS> terraform init

	Initializing the backend...

	Initializing provider plugins...
	- Reusing previous version of hashicorp/kubernetes from the dependency lock file
	- Using previously-installed hashicorp/kubernetes v2.11.0

	Terraform has been successfully initialized!

	You may now begin working with Terraform. Try running "terraform plan" to see
	any changes that are required for your infrastructure. All Terraform commands
	should now work.

	If you ever set or change modules or backend configuration for Terraform,
	rerun this command to reinitialize your working directory. If you forget, other
	commands will detect it and remind you to do so if necessary.
	```

- formateamos el/los archivos necesarios

	```console
	PS> terraform fmt
	```
	
- Validamos el/los archivos

	```console
	PS> terraform validate
	Success! The configuration is valid.
	```

- verificamos el plan de ejecucion ofrecido por terraform

	```console
	PS> terraform plan
	Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
	  + create

	Terraform will perform the following actions:
	```

- Si todo se muestra en el plan como lo planeado entonces lo aplicamos

	```console
	PS> terraform apply

	Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
	  + create

	Terraform will perform the following actions:
	```

- se debes aceptar para aprobar 

	```console
	PS> Plan: 3 to add, 0 to change, 0 to destroy.

		Do you want to perform these actions?
		  Terraform will perform the actions described above.
		  Only 'yes' will be accepted to approve.

		  Enter a value: yes
	```
	
-- se puede validar los namespace creados a traves del siguiente comando

	```console
	PS> kubectl get namespace
	NAME                   STATUS   AGE
	default                Active   3d9h
	kube-node-lease        Active   3d9h
	kube-public            Active   3d9h
	kube-system            Active   3d9h
	kubernetes-dashboard   Active   3d9h
	ns-devops              Active   4m
	```
	
-- si queremos conocer todos los recursos creados a traves de terraform 

	```console
	PS> kubectl get all -n ns-devops
	NAME                                 READY   STATUS    RESTARTS   AGE
	pod/dpy-jenkins-58f594c4b8-hlsk2     1/1     Running   0          8m24s
	pod/dpy-sonarqube-85f7c99987-prx25   1/1     Running   0          8m24s

	NAME                    TYPE       CLUSTER-IP      EXTERNAL-IP   PORT(S)                         AGE
	service/scv-jenkins     NodePort   10.108.88.123   <none>        8080:30392/TCP,5000:30393/TCP   8m24s
	service/scv-sonarqube   NodePort   10.98.246.146   <none>        9000:30450/TCP,9092:30460/TCP   8m24s

	NAME                            READY   UP-TO-DATE   AVAILABLE   AGE
	deployment.apps/dpy-jenkins     1/1     1            1           8m24s
	deployment.apps/dpy-sonarqube   1/1     1            1           8m24s

	NAME                                       DESIRED   CURRENT   READY   AGE
	replicaset.apps/dpy-jenkins-58f594c4b8     1         1         1       8m24s
	replicaset.apps/dpy-sonarqube-85f7c99987   1         1         1       8m24s
	```
	
- En caso que se quiera eliminar la infraestructura completa para probar las acciones con el IaC de K8s ejecutar el siguiente comando

	```console
	PS> terraform destroy
	kubernetes_namespace.devops: Refreshing state... [id=ns-devops]
	kubernetes_service.jenkins: Refreshing state... [id=ns-devops/scv-jenkins]
	kubernetes_service.sonarqube: Refreshing state... [id=ns-devops/scv-sonarqube]
	kubernetes_deployment.sonarqube: Refreshing state... [id=ns-devops/dpy-sonarqube]
	kubernetes_deployment.jenkins: Refreshing state... [id=ns-devops/dpy-jenkins]

	Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
	  - destroy

	Terraform will perform the following actions:
	```

- para la destruccion del plan completo se requiere aceptar para confirmar

	```console
	PS> Do you really want to destroy all resources?
	  Terraform will destroy all your managed infrastructure, as shown above.
	  There is no undo. Only 'yes' will be accepted to confirm.

	  Enter a value: yes

	kubernetes_namespace.devops: Destroying... [id=ns-devops]
	kubernetes_service.sonarqube: Destroying... [id=ns-devops/scv-sonarqube]
	kubernetes_service.jenkins: Destroying... [id=ns-devops/scv-jenkins]
	kubernetes_deployment.jenkins: Destroying... [id=ns-devops/dpy-jenkins]
	kubernetes_deployment.sonarqube: Destroying... [id=ns-devops/dpy-sonarqube]
	kubernetes_deployment.jenkins: Destruction complete after 0s
	kubernetes_deployment.sonarqube: Destruction complete after 0s
	kubernetes_service.sonarqube: Destruction complete after 0s
	kubernetes_service.jenkins: Destruction complete after 1s
	kubernetes_namespace.devops: Still destroying... [id=ns-devops, 10s elapsed]
	kubernetes_namespace.devops: Still destroying... [id=ns-devops, 20s elapsed]
	kubernetes_namespace.devops: Destruction complete after 25s
	```

**K8s:**

- Para realizar las acciones debe de ir a cada una de las siguientes carpetas y realizar los pasos posteriores

 Dirigirse a la carpeta [deployment-service\k8s](https://github.com/emejia1/sisa/tree/main/docker-projects/deployment-service/k8s)
 Dirigirse a la carpeta [deployment-devops\k8s] (https://github.com/emejia1/sisa/tree/main/docker-projects/deployment-devops/k8s)

- se deben ejecutar los archivos para crear la estructura ejecutando el siguiente comando

	```console
	PS> kubectl apply -f ./
	```


- En caso que se requiera destruir la infraestructura debera ejecutar el siguiente comando

	```console
	PS> kubectl delete -f ./
	```
	
-- si queremos conocer todos los recursos creados a traves de k8s 

	```console
	PS> kubectl get all -n ns-devops
	NAME                                 READY   STATUS    RESTARTS   AGE
	pod/dpy-jenkins-58f594c4b8-hlsk2     1/1     Running   0          8m24s
	pod/dpy-sonarqube-85f7c99987-prx25   1/1     Running   0          8m24s

	NAME                    TYPE       CLUSTER-IP      EXTERNAL-IP   PORT(S)                         AGE
	service/scv-jenkins     NodePort   10.108.88.123   <none>        8080:30392/TCP,5000:30393/TCP   8m24s
	service/scv-sonarqube   NodePort   10.98.246.146   <none>        9000:30450/TCP,9092:30460/TCP   8m24s

	NAME                            READY   UP-TO-DATE   AVAILABLE   AGE
	deployment.apps/dpy-jenkins     1/1     1            1           8m24s
	deployment.apps/dpy-sonarqube   1/1     1            1           8m24s

	NAME                                       DESIRED   CURRENT   READY   AGE
	replicaset.apps/dpy-jenkins-58f594c4b8     1         1         1       8m24s
	replicaset.apps/dpy-sonarqube-85f7c99987   1         1         1       8m24s
	```

## **Creacion de port-forward a los puertos de los servicios**

**NOTA:** Como es una prueba se realizara un port-forward sin embargo tambien se puede configurar minikube-portforward, conf.d and ssl para que estos tuneles queden de forma permanente

- port-forward para jenkins y sera consultado desde http://localhost:30392/

	```console
	PS> kubectl port-forward service/scv-jenkins 30392:8080
	```
	
- port-forward para sonarcube y sera consultado desde http://localhost:30393/

	```console
	PS> kubectl port-forward service/scv-sonarqube 30393:9000
	```
	
- port-forward para consumo del servicio y sera consultado desde http://localhost:30394/

	```console
	PS> kubectl port-forward service/scv-emejia 30394:7082
	```

