# CI-CD Pipeline for Flask-App using GitHub-Actions
##  ⚙️Overview

This project uses **GitHub Actions** to automate testing and deployment of a Python Flask app.

### Workflow Steps

- 🔧 **Install Dependencies**: Installs Python packages via `pip`.
- ✅ **Run Tests**: Runs unit tests using `pytest`.
- 📦 **Build**: Packages the app into a `.tar.gz` artifact.
- 🚀 **Deploy to Staging**: On push to `staging` branch → deploys to staging EC2.
- 🚢 **Deploy to Production**: On new GitHub release tag → deploys to production EC2.

## 1) Create GitHub Actions Workflow File `main.yml`

### Jobs

#### 🔧 Build and Test  
- Checks out the code  
- Sets up Python environment  
- Installs dependencies  
- Runs tests  
- Packages the app into an artifact  

#### 🚀 Deploy to Staging  
- Triggered on pushes to the `staging` branch  
- Downloads the build artifact  
- Deploys to the staging EC2 instance  

#### 🚢 Deploy to Production  
- Triggered on new GitHub release `tags`  
- Downloads the build artifact  
- Deploys to the production EC2 instance  


<img width="1505" height="783" alt="Screenshot 2025-09-27 180838" src="https://github.com/user-attachments/assets/052875c3-bc44-427c-b93d-08855842240c" />

Create a shell file to handles all the server-side setup and app startup tasks (like managing services with systemctl), making the deployment process easier to maintain and extend.


<img width="1632" height="1079" alt="Screenshot 2025-09-27 180918" src="https://github.com/user-attachments/assets/05b9fb7d-d760-43c8-af34-38d7aac20ebc" />

## 2) Configure the secrets
Go to **Settings** → **Secrets and variables** → **Actions** → **New repository secret**
-  `STAGING_IP`: IP address of the staging server.
-  `PRODUCTION_IP`: IP address of the production server.
-  `EC2_SSH_KEY`: Private SSH key for accessing both servers.

<img width="1023" height="910" alt="Screenshot 2025-09-27 180745" src="https://github.com/user-attachments/assets/37a906d0-6717-4159-8345-b97105d35a78" />



## 3) Create two EC2 instances for staging and production
Open port `5000` for flask app to run and `22` for SSH
<img width="1621" height="864" alt="Screenshot 2025-09-27 182053" src="https://github.com/user-attachments/assets/cbc45428-e738-4d23-b127-c19838b8ee5a" />
<img width="1625" height="870" alt="Screenshot 2025-09-27 182021" src="https://github.com/user-attachments/assets/14df23b7-ed38-4fba-94ab-1f30a28b9586" />


## 4) Trigger the Pipeline

### - Push to `staging` Branch  
Trigger the pipeline by pushing changes to the `staging` branch.  
<img width="1634" height="770" alt="Screenshot 2025-09-27 181116" src="https://github.com/user-attachments/assets/53264db5-c0e2-4a1e-97b1-c65ec07d1196" />


### - Create a New Release Tag  
Trigger the pipeline by tagging a new release in GitHub.  
<img width="1350" height="781" alt="Screenshot 2025-09-27 181327" src="https://github.com/user-attachments/assets/2e3efce1-7c64-4179-955d-9d2eedf5ab51" />


<img width="1649" height="780" alt="Screenshot 2025-09-27 181135" src="https://github.com/user-attachments/assets/b17ef7c2-56f7-47f1-b626-e2edc8c5f428" />


## 5) Verify Deployment on EC2

- **Staging:** Connect to the `github-action-staging` EC2 instance and confirm the Flask app is running (e.g., access `http://<staging-ip>:5000`).
 <img width="1436" height="797" alt="Screenshot 2025-09-27 183204" src="https://github.com/user-attachments/assets/a6db7b5c-4d41-46a5-8695-75b0bba43202" />
 
- **Production:** Connect to the `github-action-production` EC2 instance and verify the Flask app is running as expected.




<img width="1042" height="560" alt="Screenshot 2025-09-27 181148" src="https://github.com/user-attachments/assets/5f757af7-abdd-4613-bbf9-f601142f873f" />

