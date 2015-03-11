name             'pxeserver'
maintainer       'Andreas Loibl'
maintainer_email 'andreas@andreas-loibl.de'
license          'All rights reserved'
description      'Installs and configures a server for PXE booting.'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.0.0'

depends "apt"
depends "tftp"
depends "nfs"

%w{debian ubuntu}.each do |os|
  supports os
end
