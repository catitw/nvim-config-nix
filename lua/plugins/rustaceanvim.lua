-- https://www.lazyvim.org/extras/lang/rust#rustaceanvim
return {
  'mrcjkb/rustaceanvim',
  ft = { 'rust' },
  opts = {
    server = {
      default_settings = {
        ['rust-analyzer'] = {
          procMacro = {
            enable = true,
            ignored = {
              -- do NOT ignore `async-trait`
              ['napi-derive'] = { 'napi' },
              ['async-recursion'] = { 'async_recursion' },
            },
          },
        },
      },
    },
  },
}
