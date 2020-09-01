arr = [
    ['O', 'O'],
    ['X', 'O']
]

results = arr.select.with_index do |val, i|
    val[i][1]
end

pp results