#!/bin/bash
install_test() {
	echo "----------------------------"
	echo "以下是检查结果"
	echo 
	echo "0、判断系统版本"
	echo 
#		if
#		cat /etc/os-release |grep debian > /dev/null 2>&1
#		uname -a | grep x86_64 > /dev/null 2>&1
#		then
#			echo "系统具备安装条件"
#		else
#			echo "系统不具备安装条件，建议安装 debian_x64"
#			echo 
#		fi
			if [ ! -z "`cat /etc/issue | grep bian`" ];then
				if [ ! -z "`uname -a | grep x86_64`" ];then
						echo "系统版本符合要求"
					else
						echo "系统不具备安装条件。建议安装debian_x64"
				fi
				else
					echo "系统不具备安装条件。建议安装debian_x64"
			fi
	echo 
	echo "1、检查目录是否存在"
	echo
	        if [ ! -d ./v2ray ]; then
		       mkdir ./v2ray
	       else
			echo "路径'/root/'存在'v2ray'文件夹,已经将其重命名 v2ray.back"
		  	mv ./v2ray ./v2ray.back
			mkdir ./v2ray1	
		fi	
	echo
	echo "2、检查 是否安装 unzip"
	echo 
		if  command -v unzip --help > /dev/null 2>&1;then
			echo "unzip 已经存在"
		else
			echo "需要安装 unzip"
			read -p "是否 安装 'unzip' ？[y/n]: " unzip
				[ -z "$unzip" ] && unzip='y'
			if [[ $unzip == 'y' ]];then
				echo "unzip install"
				apt-get install unzip -y
			fi	
		fi
	echo
	echo "3、检查 'wget' 是否安装"
	echo
		if  command -v wget --help > /dev/null 2>&1;then
			echo "wget 已经存在"
		else
			echo "需要安装 wget"
			read -p "是否 安装 'wget' ？[y/n]: " wget
				[ -z "$wget" ] && wget='y'
			if [[ $wget == 'y' ]];then
				echo "wget install"
				apt-get install wget -y
			fi
#		if [ -n $unzip $wget ];then
#			read -p "是否 安装 $unzip $wget ?[y/n]: " installxx
#				[ -z "$installxx" ] && installxx='y'
#	                        if [[ $installxx == 'y' ]];then
#					echo "$wget $unzip"
#				fi
#
#		else
#			echo 
#			echo "可以安装v2ray"
		fi
}
install() {
#	echo "install v2ray_version=$version"
#	wget -q -O latest https://github.com/v2ray/v2ray-core/releases/latest
#	versions=$(cat latest | grep 'Release v'| awk '{printf $2}')
	versions=$(wget -q -O - https://github.com/v2ray/v2ray-core/releases | grep 'releases/tag/v' | awk  -F '[/"]' '{print $7}')  #作用：获取版本列表。参数说明 "-q" quiet选项以关闭wget输出 "-" 将输出转储到标准输出 "-O" 文件另存为，awk参数 -F 定义多个分隔符此处分隔符方括号内的内容[/"]
	clear
#	versions=$(wget -q -O - https://github.com/v2ray/v2ray-core/releases/latest | grep 'Release v'| awk '{printf $2}')
#	echo "请选择安装的版本"
#	echo "install v2ray_version=$version"
	echo "$versions
	"
	read -p "请输入需要安装的版本：" version
#		case $version in
		result=$( echo "$versions" | grep "$version" )
			if [[ "$result" == $version ]]; then
				wget https://github.com/v2ray/v2ray-core/releases/download/$version/v2ray-linux-64.zip
				unzip -d /home/v2ray/ v2ray-linux-64.zip
				cp /home/v2ray/*/v2ray /home/v2ray/
				chmod +x /home/v2ray/v2ray
				uuid=$(cat /proc/sys/kernel/random/uuid)
			else
				echo "------------"
				echo "请重新运行并输入正确的符号和数值 e.g:v2.30"
				exit
			fi
#	wget https://github.com/v2ray/v2ray-core/releases/download/$version/v2ray-linux-64.zip
#	unzip -d /home/v2ray/ v2ray-linux-64.zip
#	cp /home/v2ray/*/v2ray /home/v2ray/
#	chmod +x /home/v2ray/v2ray
#	uuid=$(cat /proc/sys/kernel/random/uuid)
	exit 1
}
update() {
	echo "update"
	exit 1
}
uninstall() {
	echo "uninstall"
	exit 1
}
while : 
do 
	echo 
	echo "0:安装准备检查"
	echo "1:安装"
	echo "2:更新"
	echo "3:卸载"
	echo "4:退出"
	echo 
	read -p "请输入序列号: " input
	case $input in 
		0)install_test;;
		1)install;;
		2)update;;
		3)uninstall;;
		4)exit;;
		*)echo "------------" 
		  echo "请输入正确的序列号"
	esac
done
