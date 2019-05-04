theme = 'dark'
if theme == 'dark'
  bkground = 'rgba(#000, 0.5)'
else if theme == 'light'
  bkground = 'rgba(#FFF, 0.1)'
else
  bkground = 'rgba(#000, 0.5)'

command: "./public_ip2.widget/script.sh"

refreshFrequency: '1m'

style: """
  left 335px
  top 10px

  color white1
  white-space nowrap
  padding 1pxpx 1px 1pxpx 1px
  align-items right
  display flex
  color #fff
  font-family Helvetica Neue
  text-align left
  padding-left 0px


  div
    display: block
    text-shadow: 0 0 1px rgba(#000, 0.5)
    background: #{bkground}
    font-size: 21px
    font-weight: 100
    border-radius 5px
    width 170px

  .content
    padding: 1px
    font-size: 10px
    font-weight: 500
    color: #fff
    margin: 1px

"""


render: -> """
  <div class='container'>
  <a class='content'>Public IP</a><br>
  <a class='ip_address'></a>
  </div>
"""

update: (output, domEl) ->
  result = output.split " "
  start = result[0].split ":"
  if start[0] == 'http'
    $(domEl).find('.ip_address').html('Not Connected')
  else
    $(domEl).find('.ip_address').html(result[0])

