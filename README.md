# Version setter

Automatically set the version for the project, based on the git tag. It makes possible to store a constans with a label and each build will set the version so when the user want to get the version of the project, it will be easy to get the proper version number.

### Installation

```
git clone git@github.com:PumpkinSeed/version-setter.git
cd version-setter
make deploy
```

### Usage

In your project create a variable or constans with the `%%VERSION%%` value.

```
// test.go
package main

const version = "%%VERSION%%"

func main() {
    println(version)
}
```

Build the project with version-setter

```
VERSIONED_FILE=test.go BUILD_CMD="go build -o testcmd test.go" versionsetter
```

### Options

- `VERSIONED_FILE` - file contains the `%%VERSION%%` label
- `BUILD_CMD` - command which builds the binary