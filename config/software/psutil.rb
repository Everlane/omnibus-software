name "psutil"
default_version "3.3.0"

dependency "python"
dependency "pip"

build do
  ship_license "https://raw.githubusercontent.com/giampaolo/psutil/master/LICENSE"
  if ohai['platform'] == 'windows'
    pip_call "install -I --install-option=\"--install-scripts="\
             "'#{install_dir}\\bin'\" #{name}==#{version}"
  else
    pip_call "install -I --install-option=\"--install-scripts=#{install_dir}/bin\""\
             "#{name}==#{version}"
  end
end
