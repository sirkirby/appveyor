# AppVeyor Powershell scripts
Scripts for use with the scripting events available in the CI pipeline. Full docs available here http://www.appveyor.com/docs

## Scripting events

- On build success
- On build error
- On build finish
- Init
- Install
- Before build
- After build
- Before tests
- After tests
- Before deployment
- After deployment

## Scripts

### SetTargetAssemblyVersionToEnvVariable

#### Params
- assemblyPath [string] [required]
- versionEnvVariable [string] [optional] [default:**X_assembly_version**]
- conditionEnvVariable [string] [optional] [default:**X_deploy**]

#### Usage
web interface event (select PS and place in text box)

```powershell
SetTargetAssemblyVersionToEnvVariable.ps1 -assemblyPath src/myProject/bin/Release/myProject.dll -versionEnvVariable myproj_assembly_version -conditionEnvVariable myproj_deploy
```

appveyor.yml

```yml
after_build:
	- ps: SetTargetAssemblyVersionToEnvVariable.ps1 -assemblyPath src/myProject/bin/Release/myProject.dll -versionEnvVariable myproj_assembly_version -conditionEnvVariable myproj_deploy
deploy:
- provider: GitHub
  tag: v$(myproj_assembly_version)
  release: v$(myproj_assembly_version) release
  description: $(APPVEYOR_REPO_COMMIT_MESSAGE)...$(APPVEYOR_REPO_COMMIT_MESSAGE_EXTENDED)
  auth_token:
    secure: myEncryptedAuthToken
  artifact: /.*\.nupkg/
  draft: true
  on:
    branch: master
    myproj_deploy: True # will only deploy when condition set to True

```
*Assumes the script is located in the root of the repository*