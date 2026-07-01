// Sets WezTerm tab title with colored status tokens driven by opencode session events.
// Only active when WEZTERM_PANE is set (i.e. running inside WezTerm).

export const TitleStatus = async ({ $, directory }) => {
  const project = directory.split('/').filter(Boolean).pop() || 'opencode'
  const pane = process.env.WEZTERM_PANE

  const setTitle = async (token) => {
    if (!pane) return
    try {
      await $`wezterm cli set-tab-title ${token + ' ' + project}`
    } catch (_) {}
  }

  let lastSessionStatus = 'done'

  return {
    event: async ({ event }) => {
      const type = event?.type
      if (type === 'session.status') {
        const st = event.properties?.status?.type
        if (st === 'busy') {
          lastSessionStatus = 'working'
          await setTitle('[oc:working]')
        } else if (st === 'idle') {
          lastSessionStatus = 'done'
          await setTitle('[oc:done]')
        } else if (st === 'error') {
          lastSessionStatus = 'error'
          await setTitle('[oc:error]')
        }
      } else if (type === 'permission.asked') {
        await setTitle('[oc:waiting]')
      } else if (type === 'permission.replied') {
        await setTitle('[oc:' + lastSessionStatus + ']')
      }
    },
  }
}
