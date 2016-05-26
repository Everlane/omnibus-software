name "python-etcd"
default_version "0.4.2"

dependency "python"
dependency "pip"

build do
  ship_license "https://raw.githubusercontent.com/jplana/python-etcd/master/LICENSE.txt"
  pip "install -I --install-option=\"--install-scripts=#{install_dir}/bin\" python-etcd==#{version}"
end
