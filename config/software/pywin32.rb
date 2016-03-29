name 'pywin32'
default_version '219'

if ohai['kernel']['machine'] == 'x86_64'
  wheel_name = "pywin32-#{version}-cp27-none-win_amd64.whl"
  wheel_md5 = '79047dc39b6b0c7b45641730ef4212fe'
else
  wheel_name = "pywin32‑#{version}‑cp27‑none‑win32.whl"
  wheel_md5 = '79047dc39b6b0c7b45641730ef4212fe'
end

source :url => "https://s3.amazonaws.com/dd-agent-omnibus/#{wheel_name}",
       :md5 => wheel_md5

dependency "python"
dependency "pip"

build do
    relative_path "pywin32-#{version}"
    # Switch on the architecture
    pip "install pywin32-#{version}-cp27-none-win_amd64.whl "\
             "--install-option=\"--prefix=#{windows_safe_path(install_dir)}\\embedded\""
    # pywintypes is patched, it doesn't work on Python > 2.7 otherwise
    # Since we don't install it from source, we can't use the patch option of omnibus
    # Here is a manual patch, using the same options as omnibus
    patch_path = File.realpath(
      File.join(
        File.dirname(__FILE__), '..',
        'patches', 'pywin32', 'fix_pywintypes_dll_import.patch'
      )
    )
    win32_path = File.join(install_dir, 'embedded', 'Lib', 'site-packages', 'win32')
    command "patch -d \"#{win32_path}\" -p1 -i \"#{patch_path}\""
end
