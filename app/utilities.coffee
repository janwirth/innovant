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
