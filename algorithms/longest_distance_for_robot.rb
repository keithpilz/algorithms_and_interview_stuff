# ---------------------------------------------
# robot movement algorithm
# calculate_longest_distance_for_robot(10, 10, [[2,1], [9,3]], [7,8])

def calculate_longest_distance_for_robot(rows, columns, laser_coordinates, robot_coordinate, with_grid_display=false)
    laser_columns = laser_coordinates.map { |coord| coord[1] }
    laser_rows = laser_coordinates.map { |coord| coord[0] }
    robot_row, robot_column = robot_coordinate[0], robot_coordinate[1]

    if with_grid_display == true
        board = Array.new(rows) {Array.new(columns, 0)}
        laser_coordinates.each {|coordinate| paint_board(board, coordinate[0], coordinate[1]) }
        board[robot_coordinate[0]][robot_coordinate[1]] = 'ROBOT'
        p board
    end

    left_distance, left_barriers = 0, [0, *laser_columns]
    left_distance += 1 until left_barriers.include?(robot_column - left_distance - 1)

    right_distance, right_barriers = 0, [*laser_columns, columns]
    right_distance += 1 until right_barriers.include?(robot_column + right_distance + 1)

    top_distance, top_barriers = 0, [0, *laser_rows]
    top_distance += 1 until top_barriers.include?(robot_row - top_distance - 1)

    bottom_distance, bottom_barriers = 0, [*laser_rows, rows]
    bottom_distance += 1 until bottom_barriers.include?(robot_row + bottom_distance + 1)

    [top_distance, bottom_distance, left_distance, right_distance].max
end

def paint_board(board, m, n)
    # go left
    for i in (0..n) do
        board[m][i] = 1
    end
    # go right
    for i in (n..board[m].length - 1) do
        board[m][i] = 1
    end
    # go up
    for i in (0..m) do
        board[i][n] = 1
    end
    # go down
    for i in (m..board.length - 1) do
        board[i][n] = 1
    end
    board
end
