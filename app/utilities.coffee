class DataHelper

  constructor: (@rawData) ->
    @data = @filter @rawData

  filter: (rawData) ->
    data = []
    columnLabels = []

    # generate headings from first answer set
    for answer, moduleNumber in rawData[0].results

      # answer may be deactivated
      if answer.active
        console.log columnPrefix = "[#{moduleNumber}] " + answer.question.text.substr(0, 8) + '...'

        for input in answer.inputs
          columnName = columnPrefix + ' ' + input.label
          columnName = columnName + ' ' + input.labelHigh if input.labelHigh?
          columnLabels.push columnName

    data.push columnLabels

    # generate result lines
    for file in rawData

      fileResults = []

      # traverse each input in each module question set
      for answer in file.results
        if answer.active
          for input in answer.inputs
            fileResults.push input.value
          data.push fileResults

    return data


  getRaw: => @rawData

  toCsv: (data) ->

    csvString = ''

    # create CSV structure
    for row in data
      for field in row
        field = '"' + field + '"' if field.indexOf?
        csvString += field + ','
      # trim comma before newline
      csvString = csvString[0 .. csvString.length - 2] + '\n'

    #trim last char
    console.log csvString
    return csvString[0 .. csvString.length - 2] 

    # remove last char
    console.log csvString
    csvString = data.toString()

  toJsonString: =>
    "data:text/json;charset=utf-8," + encodeURIComponent(JSON.stringify(@data))

  toCsvString: =>
    "data:text/csv;charset=utf-8," + encodeURIComponent(@toCsv(@data))


module.exports =
  
  slug: (str) ->
    str = str.replace(/^\s+|\s+$/g, "").toLowerCase() # trim and force lowercase
    from = "àáäâèéëêìíïîòóöôùúüûñç·/_,:;"
    to   = "aaaaeeeeiiiioooouuuunc------"
    for i in [i..from.length]
      str = str.replace(new RegExp(from.charAt(i), "g"), to.charAt(i))
    # remove accents, swap ñ for n, etc  
    str = str.replace(/[^a-z0-9 -]/g, "").replace(/\s+/g, "-").replace(/-+/g, "-")
    # remove invalid chars, collapse whitespace and replace by -, collapse dashes
    return str # unnecessary line, but for clarity

  id: -> Math.random().toString(36).substr(2, 9);

  DataHelper: DataHelper
