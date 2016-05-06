require 'cocaine'

worker = Cocaine::WorkerFactory.create
worker.on 'generate' do |tx_channel, rx|
  Cocaine::LOG.debug tx_channel
  Cocaine::LOG.debug rx.recv
end
worker.run
