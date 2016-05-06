include_recipe 'cocaine'

package 'zlib1g-dev'

python_pip 'pillow' do
  version '2.8.0'
end
python_pip 'qrcode'

bash 'Installing QR-code example' do
  cwd '/vagrant/examples/qr'
  code 'cocaine-tool app upload && cocaine-tool app restart --name qr --profile default'
end
