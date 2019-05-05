theme = 'dark'
if theme == 'dark'
  bkground = 'rgba(#000, 0.5)'
  nameColor		= 'BLACK'
else if theme == 'light'
  bkground = 'rgba(#FFF, 0.1)'
  nameColor		= 'WHITE'
else
  bkground = 'rgba(#000, 0.5)'
  nameColor		= 'BLACK'

command: "ps axro \"%cpu,ucomm,pid\" | awk 'FNR>1' | head -n 3 | sed -e 's/^[ ]*\\([0-9][0-9]*\\.[0-9][0-9]*\\)\\ /\\1\\%\\,/g' -e 's/\\ \\ *\\([0-9][0-9]*$\\)/\\,\\1/g'"

refreshFrequency: 2000

style: """
  // top: 75px
  bottom: 360px
  left: 10px
  color: #fff
  font-family: Helvetica Neue

  table
    border-collapse: collapse
    table-layout: fixed

    &:after
      content: 'cpu'
      position: absolute
      left: 0
      top: -14px
      font-size: 10px
      color: #{nameColor}
      font-weight: 600

  td
    font-size: 12px
    font-weight: 100
    width: 108px
    max-width: 108px
    overflow: hidden
    text-shadow: 0 0 1px rgba(#000, 0.5)

  .wrapper
    padding: 4px 6px 4px 6px
    position: relative

  .col1
    background: #{bkground}
    border-radius 5px

  .col2
    background: #{bkground}
    border-radius 5px

  .col3
    background: #{bkground}
    border-radius 5px

  p
    padding: 0
    margin: 0
    font-size: 11px
    font-weight: normal
    max-width: 100%
    color: #ddd
    text-overflow: ellipsis
    text-shadow: none

  .pid
    position: absolute
    top: 2px
    right: 2px
    font-size: 10px
    font-weight: normal

"""


render: -> """
  <table>
    <tr>
      <td class='col1'></td>
      <td class='col2'></td>
      <td class='col3'></td>
    </tr>
  </table>
"""

update: (output, domEl) ->
  processes = output.split('\n')
  table     = $(domEl).find('table')

  renderProcess = (cpu, name, id) ->
    "<div class='wrapper'>" +
      "#{cpu}<p>#{name}</p>" +
      "<div class='pid'>#{id}</div>" +
    "</div>"

  for process, i in processes
    args = process.split(',')
    table.find(".col#{i+1}").html renderProcess(args...)

