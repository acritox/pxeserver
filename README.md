Chef cookbook to install a PXE server

* Depends on [apt](https://supermarket.chef.io/cookbooks/apt) cookbook.
* Depends on [tftp](https://github.com/acritox/tftp) cookbook.
* Depends on [nfs](https://supermarket.chef.io/cookbooks/nfs) cookbook.

## Usage

### pxeserver::default

Include `pxeserver` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[pxe::default]"
  ]
}
```

## Setup

Add the following chunk to your existing ISC dhcpd.conf file:

    next-server X.X.X.X;
    if exists user-class and ( option user-class = "iPXE" ) {
        filename "http://X.X.X.X:6767/boot.ipxe";
    }
    else {
        filename "undionly.kpxe";
    }

Change __X.X.X.X__ to the IP of the `pxeserver` node.
Adjust the port accordingly: default: __6767__, can be changed in your node's `attributes`:

```json
{
  "pxeserver": {
    "httpdport": 6767
  }
}
```
