<!-- Remember to enable the generated Table of Contents, unless it doesn't make sense to:
It is located under Params > [x] Show Content Table, on the sidebar -->

<!-- Don't forget to set the tags accordingly, both for OS and post content, at the bottom of the page -->

<!-- If you are writing article for Torizon docs, use the paragraph below as the last thing in the introduction -->
<!-- This article complies to the [Typographic Conventions for Torizon Documentation](https://developer.toradex.com/knowledge-base/typographic-conventions-for-torizon-documentation "Typographic Conventions for Torizon Documentation"). -->

# Introduction #

Xnor.ai released the AI2GO platform which provides access to deep learning models that can be easily embedded in your Toradex board with Xnor SDK Samples.
This article shows a step-by-step how to use the platform and put a model downloaded from AI2GO to running on an Apalis iMX6.

# Prerequisites #

You must have:

- An Ixora carrier board
- An Apalis iMX6 flashed with [Toradex Embedded Linux Demo with LXDE (stable)](https://developer.toradex.com/getting-started/module-1-from-the-box-to-the-shell/installing-the-operating-system-ixora?som=apalis-imx6&board=ixora-carrier-board&os=linux)
- Linux host configured with the [Toradex cross toolchain SDK](https://developer.toradex.com/getting-started/module-2-my-first-hello-world-in-c/configure-toolchain-apalis-imx6?som=apalis-imx6&board=ixora-carrier-board&os=linux "Toradex Angstrom SDK")
- Linux host with unzip package installed
- Linux host with openssh-client package installed

# AI2GO #

## Login ##

Firstly, to access the available model settings and options, you must log in to the AI2GO platform. Sign in: [https://ai2go.xnor.ai/login](https://ai2go.xnor.ai/login "Xnor AI2GO Login")

Read and accept the terms of service:

![Terms of Service](https://docs.toradex.com/106271-logincreateaccountxnor.png?h=350 "")
</br>

After accepting the terms of service, the `LOG IN` button will be enabled. To create an account you can use the sign up services of Github, Google, Linkedin or an email with password.

![AI2GO Sign up](https://docs.toradex.com/106272-ai2gosignup.png?h=350 "")
</br>

After login, click on `DOWNLOAD BUNDLE` to access the AI2GO platform options.

## 1. Select Hardware ##

Click on `Toradex` option:

![AI2GO Sign up](https://docs.toradex.com/106273-ai2goselecttoradex.png?h=450 "")
</br>

## 2. Select the Use Case ##

In this section you can choose among 4 types of industry. Each industry has several use cases that can be chosen. For the example of this article choose `Smart Home`:

![AI2GO Select industry](https://docs1.toradex.com/106274-aigoselectindustry.png?h=450 "")
</br>

Just below in the page you can still filter the models by `tasks`: Detection, Multi-Class or Classification. For the example of this article select the Multi-Class filter:

![AI2GO Filter by task](https://docs.toradex.com/106275-ai2gofiltertask.png?h=450 "")
</br>

With the selected filter click on the `Indoor Object Classifier` option and click on the `CONTINUE` button:

![AI2GO select use case and continue](https://docs.toradex.com/106276-ai2goselectusecaseandcontinue.png?h=450 "")
</br>

## 3. Pretuned Models ##

In this session you can choose and download models that were pretuned according to the options selected in the previous steps. The first option that the platform gives is the `QUICK START` model, this will be the one chosen for the example of this article:

![AI2GO quick start model](https://docs1.toradex.com/106277-ai2goquickstartmodel.png?h=450 "")
</br>

The platform also allows the download of other models with customized options, the user can select latency time response and memory for better adaptation of your application in the `ADVANCED MODE`:

![AI2GO Pretuned advanced mode](https://docs1.toradex.com/106278-ai2gopretunedadvancedmode.png?h=550 "")
</br>

## 4. Download Bundle and SDK ##

The last step inside the AI2GO platform is the download of the Xnor model and SDK:

![AI2GO Download Bundle](https://docs1.toradex.com/106279-ai2godownloadbundle.png?h=550 "")
</br>

With this we can use the samples from the Xnor SDK with the pretuned model downloaded from AI2GO.

# Building and Running a Sample #

## Building ##

Unzip the downloaded files and configure your linux host to cross compile with the Toradex SDK toolchain.

In the Xnor SDK folder we have the following structure:

```bash
xnor-sdk\$ ls
docs  include  lib  LICENSE.txt  README.txt  samples
```

The samples for Apalis iMX6 will be inside the `samples/toradex-apalis-imx6/c` folder with the following structure:

```bash
xnor-sdk\samples\toradex-apalis-imx6\c\$ ls
classify_image_file.c                model_benchmark.c
common_util                          object_detector.c
detect_and_print_objects_in_image.c  qt-demo
json_dump_objects_in_image.c         README.md
Makefile                             segmentation_mask_of_image_file_to_file.c
```

In this folder compile the examples with the command:

```bash
xnor-sdk\samples\toradex-apalis-imx6\c\$ make
```

If everything builds correctly we will have the samples compiled for Apalis iMX6 in the `build` folder:

```bash
xnor-sdk\samples\toradex-apalis-imx6\c\build\$ ls
classify_image_file                libxnornet.so
common_util                        model_benchmark
detect_and_print_objects_in_image  object_detector
json_dump_objects_in_image         segmentation_mask_of_image_file_to_file
```

During the build the Xnor SDK generates a generic model for use with the samples, the `libxnornet.so` file. To use the pretuned model downloaded from AI2GO, copy and override the `libxnornet.so` file extracted from zip:

```bash
~$ unzip indoor-object-classifier-large-200.zip
~$ cp indoor-object-classifier-large-200/libxnornet.so xnor-sdk/samples/toradex-apalis-imx6/c/build/
```

## Copying Build to Board ##

With Ixora plugged in and connected to the network, copy the `build` folder generated during compile to the board using SSH:

{.warning} Remember to change `<board ip>` from the command below to the ip address assigned to the board.

```bash
xnor-sdk\samples\toradex-apalis-imx6\c\$ scp -r build/ root@<board ip>:/home/root
```

For the correct execution of the example you also need to copy some libs from the local Linux host toolchain to the board, run the command:

```bash
xnor-sdk\samples\toradex-apalis-imx6\c\$ scp /usr/local/oecore-x86_64/sysroots/armv7at2hf-neon-angstrom-linux-gnueabi/usr/lib/libatomic.so* root@<board ip>:/usr/lib/
```

## Running the Sample ##

On linux running on the board, open a new terminal and go to the `/home/root/build/` folder, the folder where we copied the cross compiled programs:

```bash
/home/root/build/# ls
classify_image_file                libxnornet.so
common_util                        model_benchmark
detect_and_print_objects_in_image  object_detector
json_dump_objects_in_image         segmentation_mask_of_image_file_to_file
```

For the example of this article we selected the `Indoor Object Classifier` model, which is pretuned to classify people, cats and dogs into images. Therefore, the executable `classify_image_file` sample will be used:

```bash
/home/root/build/# ./classify_image_file
Usage: ./classify_image_file <image.jpg>
```

This sample expects a JGP image as input for classify. To do this, download an image that you want to classify and put as input to the program. Examples:

![AI2GO example classify dog](https://docs.toradex.com/106280-dog-on-library.jpg?h=300 "")
</br>

```bash
/home/root/build/# wget https://docs.toradex.com/106280-dog-on-library.jpg
/home/root/build/# ./classify_image_file 106280-dog-on-library.jpg
                 .------------------------.
.----------------( Xnor.ai Evaluation Model )-----------------.
|                 '------------------------'                  |
| You're using an Xnor.ai model for evaluation purposes only. |
| This evaluation version has a limit of 10000 inferences per |
| startup, after which an error will be returned.  Commercial |
| Xnor.ai models do not contain this limit or this message.   |
| Please contact Xnor.ai for commercial licensing options.    |
'-------------------------------------------------------------'
This looks like... dog

```

![AI2GO classify example cat](https://docs.toradex.com/106281-balaio-de-gato.jpg?h=300 "")
</br>

```bash
/home/root/build/# wget https://docs.toradex.com/106281-balaio-de-gato.jpg
/home/root/build/# ./classify_image_file 106281-balaio-de-gato.jpg
                  .------------------------.
.----------------( Xnor.ai Evaluation Model )-----------------.
|                 '------------------------'                  |
| You're using an Xnor.ai model for evaluation purposes only. |
| This evaluation version has a limit of 10000 inferences per |
| startup, after which an error will be returned.  Commercial |
| Xnor.ai models do not contain this limit or this message.   |
| Please contact Xnor.ai for commercial licensing options.    |
'-------------------------------------------------------------'
This looks like... cat

```

![AI2GO classify example people](https://docs.toradex.com/106282-people.jpg?h=350 "")
</br>

```bash
/home/root/build/# wget https://docs.toradex.com/106282-people.jpg
/home/root/build/# ./classify_image_file 106282-people.jpg
                  .------------------------.
.----------------( Xnor.ai Evaluation Model )-----------------.
|                 '------------------------'                  |
| You're using an Xnor.ai model for evaluation purposes only. |
| This evaluation version has a limit of 10000 inferences per |
| startup, after which an error will be returned.  Commercial |
| Xnor.ai models do not contain this limit or this message.   |
| Please contact Xnor.ai for commercial licensing options.    |
'-------------------------------------------------------------'
This looks like... person

```
