local status_ok, neoconf = pcall(require, 'neoconf')
if not status_ok then
  return
end

neoconf.setup({})
