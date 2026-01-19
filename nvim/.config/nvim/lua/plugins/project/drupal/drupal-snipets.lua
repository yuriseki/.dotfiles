if not require("utils.project").isDrupalProject() then
  return {}
end

return {
  "L3MON4D3/LuaSnip",
  dependencies = { "rafamadriz/friendly-snippets" },
  config = function()
    local ls = require("luasnip")
    -- example Drupal snippet: hook_form_alter
    ls.add_snippets("php", {
      ls.parser.parse_snippet(
        "hfa",
        [[
/**
 * Implements hook_form_alter().
 */
function ${1:MODULE}_form_alter(&$form, \\Drupal\\Core\\Form\\FormStateInterface $form_state, $form_id) {
  if ($form_id === '${2:form_id}') {
    // ...
  }
}
]]
      ),
      ls.parser.parse_snippet(
        "@i",
        [[
/**
 * {@inheritdoc}
 */
]]
      ),
    })
  end,
}
