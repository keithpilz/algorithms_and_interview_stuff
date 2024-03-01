# ---------------------------------------------
# robot movement algorithm
# set the 5th argument to true to view the board!

def calculate_longest_distance_for_robot(rows, columns, laser_coordinates, robot_coordinate, with_grid_display=false)
    # rearrange data
    laser_columns = laser_coordinates.map { |coord| coord[1] }
    laser_rows = laser_coordinates.map { |coord| coord[0] }
    robot_row, robot_column = robot_coordinate[0], robot_coordinate[1]

    # optional! print the board with laser lines and robot location!
    if with_grid_display == true
        board = Array.new(rows) {Array.new(columns, 0)}
        laser_coordinates.each {|coordinate| paint_board(board, coordinate[0], coordinate[1]) }
        board[robot_coordinate[0]][robot_coordinate[1]] = -1
        p board
    end

    # left distance
    #  -1 is the barrier, 0 is the leftmost index a robot could stand on
    left_distance, left_barriers = 0, [-1, *laser_columns]
    left_distance += 1 until left_barriers.include?(robot_column - left_distance - 1)

    # right distance
    # if there are 10 columns, the last index will be 9, so 10 is the barrier.
    right_distance, right_barriers = 0, [*laser_columns, columns]
    right_distance += 1 until right_barriers.include?(robot_column + right_distance + 1)

    # top distance
    #  -1 is the barrier, 0 is the topmost index a robot could stand on
    top_distance, top_barriers = 0, [-1, *laser_rows]
    top_distance += 1 until top_barriers.include?(robot_row - top_distance - 1)

    # bottom distance
    # if there are 10 rows, the last index will be 9, so 10 is the barrier.
    bottom_distance, bottom_barriers = 0, [*laser_rows, rows]
    bottom_distance += 1 until bottom_barriers.include?(robot_row + bottom_distance + 1)

    # max of all is the longest distance!
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
