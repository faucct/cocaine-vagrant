# FIXME: mk-build-deps cannot resolve the correct libswarm-dev version
package %w(libswarm2 libswarm2-xml libswarm2-urlfetcher libswarm-dev) do
  version 4.times.map { '0.6.3.0' }
end
