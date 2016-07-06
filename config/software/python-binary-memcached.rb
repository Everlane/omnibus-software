name "python-binary-memcached"
default_version "0.24.6"

dependency "python"

build do
  ship_license "MIT"
  command "#{install_dir}/embedded/bin/pip install -I #{name}==#{version}"
end
