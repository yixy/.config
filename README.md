# my config 

## 0 my configuration

Linux:

* xorg : ~/.xinitrc
* dwm & st
* zsh & oh-my-zsh : `~/.zshrc`
* ranger : `~/.config/ranger/rc.conf`
* nvim : `~/.config/nvim/init.vim`

macOS:

* yabai : `~/.yabairc` ; `~/.skhdrc`
* zsh & oh-my-zsh : `~/.zshrc`
* ranger : `~/.config/ranger/rc.conf`
* nvim : `~/.config/nvim/init.vim`

archive:

* vim (archive) : `~/.vimrc`

## 1 arch-linux 

官方文档参考： https://wiki.archlinux.org/title/Installation_guide

### 网络配置

```bash
#查找当前网络设备
ip link

#enp0s3是对应要使用的网卡device
in link set enp0s3 up

# 查找Wi-Fi
# 注意，iwlist命令需安装wireless-tools组件
iwlist enp0s3 scan | grep ESSID

# 注意，虚拟机模拟网络直连的，不需要这个配置
wpa_passphrase mywifiname mywifipaswd > internet.conf
wpa_supplicant -c internet.conf -i enp0s3 &

dhcpcd
#注意提前在root系统中安装dhcpcd： pacman -S dhcpcd

vim /etc/pacman.d/mirrorlist
#Server = https://mirror.tuna.tsinghua.edu.cn/archlinux/$repo/os/$arch

#查看IP
ip adress show
```
注意，安装完成后首次登录系统需进行网络配置，可参考后面的相关配置。

### Grub 安装

AMD CPU

```bash
pacman -S amd-ucode
```

Intel CPU

```
pacman -S intel-ucode
```

参考官方文档，若主板系统是 BIOS，就使用 MBR 分区格式。若为EFI则使用GPT 。

```bash
#BIOS
pacman -S grub
grub-install --target=i386-pc /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg

#EFI
#os-prober 用于其他os检测
pacman -S grub efibootmgr os-prober
mkdir /boot/grub
grub-mkconfig > /boot/grub/grub.cfg
grub-install --target=x86_64-efi --efi-directory=/boot
```

### 滚动更新

```bash
# 搜索可更新软件
# pacman -Ss xxx
# 新增
# pacman -S xxx
# 获取软件情报
# pacman -Sy （不推荐的）
# 强制获取软件情报
# pacman -Syy （不推荐的）
# 获取软件情报并更新
# pacman -Syu
# pacman -Syyu
# 【Pacman can update all packages on the system with just one command. This could take quite a while depending on how up-to-date the system is. The following command synchronizes the repository databases and updates the system's packages, excluding "local" packages that are not in the configured repositories】
# 【注意！！！不推荐先同步软件仓库，然后安装更新 package（pacman -Sy，再pacman -Su），这样做的风险是违反了Arch系不支持部分更新的原则】
# 删除pacman缓存
# pacman -Sc

# 卸载
# pacman -R xxx
# 卸载（包括依赖）
# pacman -Rs xxx
# 卸载（包括依赖和全局配置文件）
# pacman -Rns xxx

# 查询所有已安装软件
# pacman -Q
# 查询所有已安装的非系统软件
# pacman -Qe
# 查询所有已安装的非系统软件，不显示版本和介绍信息
# pacman -Qeq
# 在已安装软件中查找
# pacman -Qs xxx

# 删除不被依赖的软件包
sudo pacman -Rns $(pacman -Qdtq)
```

### 常用软件 & 用户权限

```bash
pacman -S openssh
pacman -S neovim
pacman -S sudo

useradd -m -d /home/youzhilane -G wheel youzhilane

# uncommon to add sudo permission to wheel group
EDITOR=nvim visudo

#setting /etc/ssh/sshd.conf
systemctl enable sshd
systemctl start sshd

#dhcpcd daemon
systemctl enable dhcpcd
systemctl start dhcpcd

pacman -S man 
pacman -S git
#tk for gitk
pacman -S tk
pacman -S inetutils
pacman -S keychain
pacman -S wget

# -p to mod password
#ssh-keygen -f /pathtokey/id_rsa -p
#.myenvrc: add ssh key to keychain
#eval $(keychain --eval --quiet /pathtokey/id_rsa

# 基础开发工具，如gcc
pacman -S base-devel

#xpn
pacman -S v2ray
systemctl enable v2ray
systemctl start v2ray
#manual: git clone https://github.com/v2ray/v2ray-core
#cd v2ray-core
#./v2ray run -c config.json

# AUR 的辅助工具 yay
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
# pacman -Qs yay


#Install the tlp package. Installing the optional dependencies may help provide additional power saving.
#
#Enable/start tlp.service.
#
#One should also mask the service systemd-rfkill.service and socket systemd-rfkill.socket to avoid conflicts and assure proper operation of TLP's radio device switching options.
pacman -S tlp tlp-rdw
systemctl enable NetworkManager-dispatcher.service
systemctl start NetworkManager-dispatcher.service
systemctl enable tlp.service
systemctl start tlp.service
systemctl stop systemd-rfkill.service systemd-rfkill.socket
systemctl mask systemd-rfkill.service systemd-rfkill.socket

pacman -S acpi
```

### systemd配置

参考 https://wiki.archlinuxcn.org/wiki/Systemd

```bash
#例子，v2ray已经安装过，不用重复配置systemd了
#sudo nvim /etc/systemd/system/v2ray.service
[Unit]
Description=V2Ray Service
Documentation=https://www.v2fly.org/
After=network.target nss-lookup.target

[Service]
User=root
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/path/v2ray/v2ray -config /path/v2ray/config.json
Restart=on-failure
RestartPreventExitStatus=23

[Install]
WantedBy=multi-user.target
```

setting service.

```bash
#reload daemon
systemctl daemon-reload

#enable service
systemctl enable v2ray.service
```

### fix EFI booting

```bash
mount FS0
FS0:
cd EFI/arch
grubx64.efi

#reinstall grub
```

## 2 xorg & dwm & st

### 安装xorg

xorg是X Server的一个实现。

* X服务器：处理用户输入，绘制窗体。
* 窗口管理器：控制所有X客户端的管理程序，提供任务栏、背景桌面、窗口大小、窗口移动重叠等能力。
* 桌面环境：在窗口管理器之上的完整桌面解决方案，一般包含一个窗口管理器和其他软件。

```
linux OS<--X服务器<--[通过X协议交互]-->窗口管理器/综合桌面环境(包含窗口管理器)-->X应用程序. 
```

```bash
pacman -S xorg xorg-server xorg-apps xorg-xinit
pacman -S lightdm 
pacman -S lightdm-gtk-greeter lightdm-gtk-greeter-settings
```

### 安装dwm和st

安装窗口管理器dwm和终端st。

参考官方文档： https://suckless.org

```bash
# install dwm
git clone git@github.com:yixy/dwm.git
sudo make clean install 

# install st
git clone git@github.com:yixy/st.git
sudo make clean install
```

`nvim ~/.Xresources`配置xorg hidp

```bash
#4k显示器的hidp设置
#e.g. 192 for 200% scaling.
Xft.dpi: 192
```

`nvim ~/.xinitrc`编辑启动配置

```bash
# 查看分辨率
#xrandr
# 设置分辨率模式
#xrandr --output Virtual-1 --mode 3840×2160
# 添加分辨率模式 add new mode if notexist
#cvt 3840 2160 60
# out put is : Modeline "3840x2160_60.00"  712.75  3840 4160 4576 5312  2160 2163 2168 2237 -hsync +vsync
#xrandr --newmode "3840x2160_60.00"  712.75  3840 4160 4576 5312  2160 2163 2168 2237 -hsync +vsync
#xrandr --addmode Virtual-1 "3840x2160_60.00"

#apply xrandr
#xrandr --output Virtual-1 --mode 2560x1600
xrandr --output Virtual-1 --mode 3840x2160

#apply hidp
xrdb -merge ~/.Xresources

#启动dwm
exec dwm

```

dwm状态更新。

```bash
mkdir ~/.scripts
cd ~/.scripts
wget https://github.com/yixy/.config/raw/main/.scripts/refresh.sh
wget https://github.com/yixy/.config/raw/main/.scripts/dwm_status.sh

mkdir ~/.dwm
cd ~/.dwm
wget https://github.com/yixy/.config/raw/main/.dwm/autostart.sh

#nvim ~/.dwm/autostart.sh
#add dwm status
bash ~/.scripts/refresh.sh &
```

启动窗口管理器。

```bash
startx
```

### 字体 

配置字体。

```bash
#查看支持的字体
fc-match -a

#查看当前系统默认字体
fc-match

#安装字体
#yay -S ttf-ubuntu-font-family
#中文字体
pacman -S noto-fonts noto-fonts-cjk
```

`nvim /etc/locale.gen`配置语言。

```bash
zh_CN.UTF-8 UTF-8
en_US.UTF-8 UTF-8  
```

使用`locale-gen`启用。

fontconfig配置可参考双猫cc的文章： https://catcat.cc/post/2021-03-07/

### 输入法

配置输入法。 参考 https://wiki.archlinux.org/title/Fcitx5

```bash
# im include qt & gtk
pacman -S fcitx5-im
pacman -S fcitx5-chinese-addons

#add to env
#export GTK_IM_MODULE=fcitx
#export QT_IM_MODULE=fcitx
#export XMODIFIERS=@im=fcitx
#export SDL_IM_MODULE=fcitx
#export GLFW_IM_MODULE=ibus

#注意，开启fcixt输入法需要配置fcitx
#nvim ~/.dwm/autostart.sh
#add fcitx
fcitx5 -d
```

进行配置。

```bash
fcitx5-configtool
```

### 壁纸效果

壁纸资源： https://wallpapertag.com/

```bash
#wallpaper manage
pacman -S nitrogen
#合成管理器，为不带合成管理器的窗口带来透明效果
#pacman -S picom # frozen, use yay to install
yay -S picom

cp /etc/xdg/picom.conf ~/.config
#关闭淡入淡出效果
#fading = false;
#关闭fcitx5的透明效果
#opacity-rule = ["100:class_g = 'fcitx'"]

#nvim ~/.dwm/autostart.sh
#add wallpapper when start
nitrogen --random --set-scaled ~/.wallpaper
picom &
```

## 3 zsh & oh-my-zsh

安装并切换到zsh

```bash
pacman -S zsh
chsh -s /bin/zsh
```

安装oh-my-zsh

```bash
#https://ohmyz.sh/#install
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

配置oh-my-zsh

```bash
#配置文件
cd ~
mv .zshrc .zshrc_bak
wget https://github.com/yixy/.config/raw/main/zsh/.zshrc
diff .zshrc .zshrc_bak

#alias rm='echo "Please try trash...";false'
#alias vpn='xxxx'
#alias novpn='export http_proxy=""; export HTTP_PROXY=""; export https_proxy=""; export HTTPS_PROXY=""'

cd ~
wget https://github.com/yixy/.config/raw/main/.myenvrc
#diff!!!
wget https://github.com/yixy/.config/raw/main/.xinitrc
#diff!!!
wget https://github.com/yixy/.config/raw/main/.Xresources

#安装提示插件
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

## 4 ranger

```bash
pacman -S ranger

#生成默认配置文件
ranger --copy-config=all

cd ~/.config/ranger
mv rifle.conf rifle.conf_bak
mv rc.conf rc.conf_bak
wget https://github.com/yixy/.config/raw/main/ranger/rifle.conf
wget https://github.com/yixy/.config/raw/main/ranger/rc.conf
diff rifle.conf rifle.conf_bak
diff rc.conf rc.conf_bak
```

## 5 nvim

配置nvim

```bash
pacman -S xclip
#pacman -S neovim
cd ~/.config/nvim/
wget https://github.com/yixy/.config/raw/main/nvim/init.vim
wget https://github.com/yixy/.config/raw/main/nvim/coc-settings.json
```

安装vim-plug

```bash
#https://github.com/junegunn/vim-plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```

安装nodejs和npm（coc的依赖）

```bash
pacman -S nodejs npm
```

打开nvim，通过`:PlugInstall`安装相关插件。

## 6.系统安装完后对网络配置

> after `arch-chroot /mnt`.

Create the hostname file:

/etc/hostname

```
<hostname>
```

Create the hosts file:

/etc/hosts

```
127.0.0.1    localhost
::1          localhost
127.0.1.1    <hostname>.localdomain    <hostname>
```

Note: The installation image uses systemd-networkd and systemd-resolved. systemd-networkd configures a DHCP client for wired and wireless network interfaces. These must be enabled and configured on the new system.

Install iwd:（iwd (iNet wireless daemon，iNet 无线守护程序) 是由英特尔（Intel）为 Linux 编写的一个无线网络守护程序。该项目的核心目标是不依赖任何外部库，而是最大程度地利用 Linux 内核提供的功能来优化资源利用。）

```
pacman -S iwd
```

```
# vi /var/lib/iwd/SSID.nettype（nettype is one of `.open`, `.psk`, `.8021x`.  eg. /var/lib/idw/xxxx.psk)
[Security]
Passphrase=wifi-passwd
```

Install broadcom-wl:

```
pacman -S broadcom-wl
```

Configure systemd-networkd:

/etc/systemd/network/20-ethernet.network

```
[Match]
Name=en*
Name=eth*

[Network]
DHCP=yes
IPv6PrivacyExtensions=yes

[DHCP]
RouteMetric=512
```

/etc/systemd/network/20-wireless.network

```
[Match]
Name=wlp*
Name=wlan*

[Network]
DHCP=yes
IPv6PrivacyExtensions=yes

[DHCP]
RouteMetric=1024
Configure systemd-resolved:
```

```
ln -sf /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf
```

Ensure systemd-networkd, systemd-resolved, and iwd start on boot:

```
systemctl enable systemd-networkd.service
systemctl enable systemd-resolved.service
systemctl enable iwd
```

```
pacman -S wpa_supplicant
```

## 7 sound 配置

参考官网wiki： https://wiki.archlinux.org/title/Advanced_Linux_Sound_Architecture

高级 Linux 声音体系（Advanced Linux Sound Architecture，ALSA）是Linux中提供声音设备驱动的内核组件，用来代替原来的开放声音系统（Open Sound System，OSSv3）。除了声音设备驱动，ALSA还包含一个用户空间的函数库，以方便开发者通过高级API使用驱动功能，而不必直接与内核驱动交互。Arch 默认的内核已经通过一套模块提供了 ALSA，不必特别安装。udev会在系统启动时自动检测硬件，并加载相应的声音设备驱动模块。这时，你的声卡已经可以工作了，只是所有声道默认都被设置成静音了。

```bash
pacman -S alsa-utils

#交互式命令关闭静音，调整音量大小
#在 alsamixer 中，下方标有 MM 的声道是静音的，而标有 00 的通道已经启用。使用 ← 和 → 方向键，选中 Master 和 PCM 声道。按下 m 键解除静音。使用 ↑ 方向键增加音量，直到增益值为0。该值显示在左上方 Item: 字段后。过高的增益值会导致声音失真。
alsamixer
```

使用alsamixer设置之后还是没有声音，则有可能网卡默认配置有误。

```bash
#查看网卡的声卡ID和设备ID
aplay -l
#查看默认网卡信息
amixer scontrols
#查看0和1号网卡信息
amixer -c 0 scontrols
amixer -c 1 scontrols
```

系统级别 /etc/asound.conf ，用户级别 ~/.asoundrc 配置。

```bash
#eg 网卡0，设备1
defaults.pcm.card 1
defaults.pcm.device 0
defaults.ctl.card 1
```
## 8 screen backlight & keyboad backlight

以macbookpro11,1为例，屏幕背光和键盘背光值可在如下目录中的找到。

```bash
$ cat /sys/class/backlight/acpi_video0/brightness
10

$ cat /sys/class/leds/smc::kbd_backlight/brightness
100
```
屏幕背光自动调整问题可参考：

https://harttle.land/2019/10/13/archlinux-backlight.html

## 9 touchpad

参考：https://harttle.land/2019/05/01/linux-macbook-trackpad-settings.html

```bash
yay -S xf86-input-mtrack
```

执行 xinput，找到设备 ID。本例中为11。

```bash
$ xinput
⎡ Virtual core pointer                          id=2    [master pointer  (3)]
⎜   ↳ Virtual core XTEST pointer                id=4    [slave  pointer  (2)]
⎜   ↳ bcm5974                                   id=11   [slave  pointer  (2)]
⎣ Virtual core keyboard                         id=3    [master keyboard (2)]
    ↳ Virtual core XTEST keyboard               id=5    [slave  keyboard (3)]
    ↳ Power Button                              id=6    [slave  keyboard (3)]
    ↳ Video Bus                                 id=7    [slave  keyboard (3)]
    ↳ Power Button                              id=8    [slave  keyboard (3)]
    ↳ Sleep Button                              id=9    [slave  keyboard (3)]
    ↳ Apple Inc. Apple Internal Keyboard / Trackpad     id=10   [slave  keyboard (3)]
```

执行`xinput list-props 11`可以查看相应的驱动参数，如下面例子中的301和309参数。

将相应参数配置持久化有两种方式：

1. 把 xinput 命令放到 .xinitrc 中，或者某种 autostart 中。
2. 把上述属性配置到 /etc/X11/xorg.conf.d/*.conf 中。——MacBookPro11,1不生效，待解决。

以xinput命令为例：

```bash
#nvim ~/.xinitrc
#轻触点击
xinput set-prop 11 301 1
#自然滚动
xinput set-prop 11 309 1
#三指拖拽待解决。。。
```

## 10 Java environment

```bash
$ sudo pacman -S jdk19-openjdk
$ sudo pacman -S jdk8-openjdk
#using archlinux-java set to specify the jdk
```

## macOS & IOS

[mac系统偏好设置](/macos/01.mac系统偏好设置.md)

[hombrew使用](/macos/02.hombrew使用.md)

[mac常用软件](/macos/03.mac常用软件.md)

[盒盖掉电问题](/macos/04.rmbp盒盖掉电问题.md)

## trouble shooting

### 【arch Linux】MacBookPro11,1安装 arch/macOS双系统

主要参考Arch Linux安装官方文档 以及下面的文档：

* https://wiki.archlinux.org/title/MacBookPro11,x
* https://nickolaskraus.io/articles/installing-arch-linux-on-a-macbookpro-part-1
* https://nickolaskraus.io/articles/installing-arch-linux-on-a-macbookpro-part-2
* https://nickolaskraus.io/articles/installing-arch-linux-on-a-macbookpro-part-3

**1.动态调整分区**

macOS更新为Big Sur最新版本。使用Disk Utility工具在左侧列中选择要分区的驱动器，点击分区（partition）。按+添加新分区，然后选择您给新分区多少空间。分区类型无关紧要，因为它在安装Arch Linux时会重新格式化，但最好将分区格式化为APFS，以免将分区与其他分区（即Windows 7分区）混淆。注意，此操作对磁盘空闲空间大小有要求，太小的话是不能动态拆分并添加分区的。此外，某些系统文件如果无法手工清理，可以使用`启动转换助理`进行清理（不用真的进行windows分区，在此之前会把timemachine的缓存清空）。

**2.制作archlinux启动U盘**

```bash
diskutil list
#在用dd写入块之前，您必须卸载（而不是弹出）它。
diskutil unmountDisk /dev/diskX
#将ISO映像文件复制到设备。dd命令与Linux命令相似，但请注意disk前的r。这是用于原始模式，这使得传输速度更快：
dd if=path/to/arch.iso of=/dev/rdiskX bs=1m
```
重新启动Mac。按住Option（⌥）键，选择Arch Linux的可引导安装程序。

**3.无线配置**

针对无线连接，根据MacBookPro型号，可能拥有Broadcom BCM43602单芯片双频收发器，该收发器由开源brcm80211模块支持，该模块内置在Linux内核中，通常默认启用。其他BCM43XX芯片组可能仅由b43或Broadcom-wl等专有驱动程序支持。broadcom-wl软件包包含在Arch Linux安装程序中，但可能需要手动启用，然后芯片组才能正常工作。b43驱动程序也内置在内核中，并包含在安装介质中，但它需要来自b43固件AUR包的外部专有固件，该固件需要从连接到互联网的另一台机器下载。可以通过运行ip link show来列出安装程序环境中可用的网络接口。如果您可以在列表中看到您的无线接口（例如wlan0），您现在应该可以使用iwctl选择并连接到无线网络。如果虚拟环回接口是唯一列出的接口，您可能需要加载替代的Broadcom驱动程序。要做到这一点，首先要确保所有Broadcom驱动程序都已卸载。

```
rmmod b43
rmmod bcma
rmmod ssb
rmmod wl
```

添加bcma模块：

```
modprobe bcma
```

如果仍然看不到无线接口，请删除bcma模块并添加wl模块：

```
rmmod bcma && modprobe wl
使用iwctl连接到Wi-Fi。
```

**4.arch分区**

参考官方文档对磁盘重新进行分区：

* EFI系统（EFI系统分区）：不变
* 苹果APFS（macOS）：不变
* 苹果APFS（Arch Linux）：删除分区，重新建swap分区和Linux root（x86-64）分区

注意，格式化时提供-L选项来设置标签,这在创建fstab文件和引导加载程序条目时很有用。

```
mkfs.ext4 /dev/<root_partition> -L "Arch"
```

**5.安装配置引导加载程序**

Apple’s native EFI boot loader reads .efi files located within the EFI system partition (/mnt/boot) at $ESP/EFI/BOOT/BOOTX64.EFI. Fortunately, this is also the default install location for the systemd-boot binary. This means that booting Arch Linux using systemd-boot is very simple.

注意：EFI系统分区应挂载到/mnt/boot（新系统中的/boot）。

注意：systemd-boot是支持UEFI的系统的推荐引导加载程序。

确保安装了EFI系统分区：

```
ls /boot
```

将systemd-boot安装到EFI系统分区中：

```
bootctl install
```

此命令将systemd-boot安装到EFI系统分区中。systemd-boot的副本将存储为EFI默认/回退加载程序，位于$ESP/EFI/BOOT/BOOT*.EFI。然后，加载程序被添加到固件引导加载程序列表的顶部。

配置systemd-boot。systemd-boot是一个简单的UEFI引导管理器，它执行已配置的EFI映像。默认条目由配置的模式（glob）或通过箭头键导航的屏幕菜单选择。它包含在systemd中，默认情况下安装在Arch Linux系统上。

加载器配置存储在$ESP/loader/loader.conf文件中。

$ESP/loader/loader.conf

```
default arch.conf
timeout 3
```

systemd-boot将在$ESP/loader/entries/*.conf中搜索引导菜单项。

$ESP/loader/entries/arch.conf

```bash
title      Arch Linux
linux      /vmlinuz-linux
initrd     /intel-ucode.img
initrd     /initramfs-linux.img
options    root="LABEL=Arch"
```

注意：示例条目文件位于/usr/share/systemd/bootctl/arch.conf。

**6.启动**

正常启动，通过UEFI可正常启动arch。

按住Option（⌥）键，选择MacintoshHD启动，这种方法可正常启动macOS。

### 【arch Linux】VirtualBox虚拟机安装

可参考如下链接。

https://wiki.archlinuxcn.org/zh-hans/VirtualBox/在虚拟机中安装_Arch_Linux

* 待解决：VirtualBox驱动不太好搞定，参考官网方法没解决，观看视频一直卡顿。

### 【arch Linux】ParallelsDesktop虚拟机安装

可参考如下链接。

https://wiki.archlinux.org/title/Parallels_Desktop

安装Parallels Tool

```bash
#Mac Dir: /Applications/Parallels\ Desktop.app/Contents/Resources/Tools/prl-tools-lin.iso
mount /dev/cdrom /mnt/cdrom
pacman -S linux-headers
pacman -S dkms
cd /mnt/cdrom
./install
```

视频播放无声音，可安装如下驱动。

```bash
$ sudo pacman -S alsa-utils alsa-firmaware
$ sudo pacman -S pulseaudio pulseaudio-alsa
$ sudo pacman -S pamixer plasma-pa
------------------------------------------------------

# !! /etc/alsa/state-daemon.conf is missed.
# sudo nano /usr/lib/systemd/system/alsa-state.service

# Note that two different ALSA card state management
# schemes exist and they can be switched using a file
# exist check - /etc/alsa/state-daemon.conf

[Unit]
Description=Manage Sound Card State (restore and store)
# ConditionPathExists=/etc/alsa/state-daemon.conf
# ConditionPathExists=!/etc/alsa/state-daemon.conf
ConditionPathExists=@daemonswitch@
After=sysinit.target

[Service]
Type=simple
ExecStart=-/usr/bin/alsactl -s -n 19 -c rdaemon
ExecStop=-/usr/bin/alsactl -s kill save_and_quit

systemctl daemon-reload
systemctl restart alsa-state.service

reboot
```

### 【arch Linux】关机慢

```bash
#nvim /etc/systemd/system.conf
DefaultTimeoutStartSec=10s
DefaultTiemoutStopSec=10s

systemctl daemon-reload
```
