usb =   require "usb"
_ =     (require "underscore")._

# usb_ids = require("../../usb_ids.js")
instance = usb.create()

# idVendor=0x0bc7, idProduct=0x0002
findDevice = (idVendor, idProduct) ->
    _.reduce instance.getDevices(), (state, dev) ->
        desc = dev.getDeviceDescriptor()
        return dev if desc.idVendor == idVendor and desc.idProduct == idProduct

dev = findDevice 0xbc7, 0x2

ints = dev.getInterfaces()
int = ints.pop()
int.claim()

endpoints = int.getEndpoints()
console.log endpoints

writeEndpoint = _.reduce endpoints, (state, endpoint) ->
    return endpoint if endpoint.bEndpointAddress == 0x4

# buff = new Buffer 0

# writeEndpoint.controlTransfer buff, 0x20, 0x60, 0x9f, 0x40, 0xbf, () ->
#     console.log "YAY"

buff = new Buffer 5
_.each [0x20, 0x60, 0x9f, 0x40, 0xbf], (k, v) ->
    buff.push i

# 0x4 or 0x2, 0x83 or 0x81
