# my config 

## 1 arch-linux install

官方文档参考： https://wiki.archlinux.org/title/Installation_guide

### 网络配置

```shell
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
```
### Grub 安装

```
#intel-ucode intel驱动
#os-prober 用于其他os检测
pacman -S grub efibootmgr intel-ucode os-prober

mkdir /boot/grub
grub-mkconfig > /boot/grub/grub.cfg
grub-install --target=x86_64-efi --efi-directory=/boot
```

### 滚动更新

```shell
# 新增、卸载、查询软件
# pacman -S xxx
# pacman -R xxx
# pacman -Qs xxx
pacman -Syyu
```

### 用户权限

```shell
user add -m -d /home/youzhilane -G wheel youzhilane

# uncommon to add sudo permission to wheel group
visudo
```

### 常用软件

```shell
pacman -S man 
pacman -S git
pacman -S inetutils
pacman -S openssh
pacman -S neovime

# 基础开发工具，如gcc
pacman -S base-devel

#xpn
git clone https://github.com/v2ray/v2ray-core
cd v2ray-core
./v2ray run -c config.json

# AUR 的辅助工具 yay
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
# pacman -Qs yay

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

```shell
pacman -S xorg xorg-server xorg-apps xorg-xinit
pacman -S lightdm 
pacman -S lightdm-gtk-greeter lightdm-gtk-greeter-settings
```

### 安装dwm和st

安装窗口管理器dwm和终端st。

参考官方文档： https://suckless.org

```shell
# install dwm
git clone https://git.suckless.org/dwm
sudo make clean install 

# install st
git clone https://github.com/theniceboy/st.git
sudo make clean install
```

`nvim ~/.Xresources`配置xorg hidp

```shell
#4k显示器的hidp设置
#e.g. 192 for 200% scaling.
Xft.dpi: 192
```

`nvim ~/.xinittrc`编辑启动配置

```shell
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
xrandr --output Virtual-1 --mode 3840x2160

#apply hidp
xrdb -merge ~/.Xresources

#apply fcitx
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
fxitx &

#启动dwm
exec dwm

```

启动窗口管理器。

```shell
startx
```

### 字体 

配置字体。

```shell
#查看支持的字体
fc-match -a

#查看当前系统默认字体
fc-match

#安装字体
yay -S ttf-ubuntu-font-family
#中文字体
pacman -S noto-fonts noto-fonts-cjk
```

`nvim /etc/locale.gen`配置语言。

```shell
zh_CN.UTF-8
```

使用`locale-gent`启用。

fontconfig配置： https://catcat.cc/post/2021-03-07/

### 输入法

配置输入法。

```shell
pacman -S fcitx-im
pacman -S fcitx-googlepinyin
pacman -S fcitx-configtool

#注意，开启fcixt输入法需要在`~/.xinitrc`中配置fcitx
#nvim ~/.xinitrc
#export GTK_IM_MODULE=fcitx
#export QT_IM_MODULE=fcitx
#export XMODIFIERS=@im=fcitx
#fcitx&
```

## 3 my configuration

* zsh : `~/.zshrc`
* ranger : `~/.config/ranger/rc.conf`
* yabai : `~/.yabairc` ; `~/.skhdrc`
* vim (archive) : `~/.vimrc`
* nvim : `~/.config/nvim/init.vim`
