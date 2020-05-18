#!/bin/bash

menu(){
	clear
	echo ""
	echo "1 代理类（V2 55R）"
	echo "2 中转类（端口转发）"
	echo "3 系统类（锐速BBR/测速/软件源）"
	echo "4 安装程序"
	echo "5 杂项"
	echo ""
	read -p "请选择脚本类型:" start
	echo ""
	case $start in
	1)
	#echo "选择1 代理类"
	daili_menu
	;;
	2)
	#echo "选择2 中转类"
	zhongzhuan_menu
	;;
	3)
	#echo "选择3 系统类"
	xitong_menu
	;;
	4)
	#echo "选择4 安装程序"
	install_menu
	;;
	5)
	#echo "选择5 杂项"
	zaxiang_menu
	;;
	esac
}
daili_menu(){
	clear
	echo ""
	echo "1 233v2ray一键脚本"
	echo "2 SSR 一键脚本"
	echo "0 返回主菜单"
	echo ""
	read -p "请选择脚本类型:" daili
	echo ""
	case $daili in
	1)
	v2_233
	;;
	2)
	ssr
	;;
	0)
	menu
	;;
	esac
}

zhongzhuan_menu(){
	clear
	echo ""
	echo "1 haproxy"
	echo "2 brook-pf"
	echo "0 返回主菜单"
	echo ""
	read -p "请选择脚本类型:" zhongzhuan
	case $zhongzhuan in
	1)
	haproxy
	;;
	2)
	brook-pf
	;;
	0)
	menu
	;;
	esac
}

xitong_menu(){
	clear
	echo ""
	echo "1 一键BBR/锐速三合一脚本"
	echo "2 一键测试网速"
	echo "3 配置Docker国内源"
	echo "4 测试回源线路"
	echo "0 返回主菜单"
	echo ""
	read -p "请选择脚本类型:" xitong
	echo ""
	case $xitong in
	1)
	tcp
	;;
	2)
	superbench
	;;
	3)
	Docker_cn
	;;
	4)
	mtr_test
	;;
	0)
	menu
	;;
	esac
}

install_menu(){
	clear
	echo ""
	echo "1 安装Docker"
	echo "2 一键测试网速"
	echo "0 返回主菜单"
	echo ""
	read -p "请选择脚本类型:" install
	echo ""
	case $install in
	1)
	docker
	;;
	2)
	superbench
	;;
	0)
	menu
	;;
	esac
}

zaxiang_menu(){
	clear
	echo ""
	echo "1 生成自定义git.io短链接"
	echo "2 "
	echo "0 返回主菜单"
	echo ""
	read -p "请选择脚本类型:" install
	echo ""
	case $install in
	1)
	git_io
	;;
	2)
	
	;;
	0)
	menu
	;;
	esac
}

#代理类
v2_233(){
	bash <(curl -s -L https://cdn.jsdelivr.net/gh/233boy/v2ray@master/install.sh)
}

ssr(){
	echo "无"
}

#中转类

haproxy(){
	bash <(curl -s -L https://cdn.jsdelivr.net/gh/ToyoDAdoubi/doubi@master/haproxy.sh)
}

brook-pf(){
	bash <(curl -s -L https://cdn.jsdelivr.net/gh/ToyoDAdoubi/doubi@master/brook-pf.sh)
}

#系统类
tcp(){
	echo "安装完内核重启后需要再执行一次"
	sleep 3
	bash <(curl -s -L https://cdn.jsdelivr.net/gh/chiakge/Linux-NetSpeed@master/tcp.sh)
}

superbench(){
	bash <(curl -s -L https://cdn.jsdelivr.net/gh/oooldking/script@master/superbench_git.sh)
}

Docker_cn(){
	echo -e '{\n"registry-mirrors": ["https://fpqqn4ib.mirror.aliyuncs.com"]\n}' > /etc/docker/daemon.json
	systemctl daemon-reload
	systemctl restart docker
	echo -e "\n已替换为国内源\n"
}

mtr_test(){
	echo "无"
}

#安装程序
docker(){
	clear
	echo ""
	echo "1 默认源"
	echo "2 阿里源(国内)"
	echo "0 返回主菜单"
	echo ""
	read -p "请选择脚本类型:" install_yuan
	echo ""
	case $install_yuan in
	1)
	curl -fsSL https://get.docker.com | bash
	;;
	2)
	curl -fsSL https://get.docker.com | bash -s docker --mirror Aliyun
	;;
	0)
	menu
	;;
	esac
}

#杂项
git_io(){
	echo "请输入原Github长链接(带https://)："
	read uurl
	if [[ "$uurl" == "" ]]; then
		git_io
	elif [[ $(echo $uurl | grep github.com) == "" ]]; then
		clear
		echo -e "链接不正确\n"
		git_io
	fi
	echo "请输入git.io短链接后缀(仅后缀)："
	read ccode
	if [[ "$ccode" == "" ]]; then
		git_io
	fi
	clear
	echo ""
	echo -e "原Github长链接为：$uurl\ngit.io短链接为：https://git.io/$ccode"
	read -p "确定无误请输入Y回车" git_io_yes
	if [[ "$git_io_yes" == [Yy] ]]; then
		curl -i https://git.io -F url=$uurl -F "code=$ccode"
		echo -e "\n短网址为：https://git.io/$ccode\n\n请自行测试是否成功\n"
	else
		git_io
	fi
}

menu
