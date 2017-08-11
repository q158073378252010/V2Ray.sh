#!/bin/bash
install_test() {
	echo "以下是检查结果"
	echo "----------------------------"
	echo "1、检查目录是否存在"
	echo
	        if [ ! -d /home/v2ray ]; then
				mkdir /home/v2ray
	       else
				echo "路径'/root/'存在'v2ray'文件夹,已经将其重命名 v2ray.back"
				mv /home/v2ray /home/v2ray.back
				mkdir /home/v2ray	
			fi
	echo
	echo "2、检查 是否安装 unzip"
	echo 
		if  command -v unzip --help > /dev/null 2>&1;then
			echo "unzip正常"
		else
			echo "需要安装 unzip"
			read -p "是否 安装 'unzip' ？[y/n]: " unzip
				[ -z "$unzip" ] && unzip='y'
			if [[ $unzip == 'y' ]];then
				echo "apt-get install unzip -y"
			fi	
		fi
	echo
	echo "3、检查 'wget' 是否安装"
	echo
		if  command -v wget --help > /dev/null 2>&1;then
			echo "wget正常"
		else
			echo "需要安装 wget"
			read -p "是否 安装 'wget' ？[y/n]: " wget
				[ -z "$wget" ] && wget='y'
			if [[ $wget == 'y' ]];then
				echo "apt-get install wget -y"
			fi

		fi

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
		*)echo "请输入正确的序列号"
	esac
done
