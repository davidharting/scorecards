require 'test_helper'

class ScoreTest < ActiveSupport::TestCase
  test 'the truth' do
    assert true
  end

  test 'just see what it fetches' do
    state = get_state
    assert_equal state.scorecard.players.size, 3
  end

  test 'lookup_score should return the score for a given player and round' do
    cases = [
      %i[one frodo frodo_one],
      %i[two frodo frodo_two],
      %i[three frodo frodo_three],
      %i[one gandalf gandalf_one],
      %i[two gandalf gandalf_two],
      %i[three gandalf gandalf_three],
      %i[one sam sam_one],
      %i[two sam sam_two],
      %i[three sam sam_three],
    ]

    state = get_state

    cases.each do |c|
      actual =
        state.lookup_score(
          player_id: players(c[1]).id,
          round_id: rounds(c[0]).id,
        )
      assert_equal actual.value, scores(c[2]).value
    end
  end

  test 'sums_ordered_by_player_id returns an array of score sums, ordered by player_id asc' do
    tuples = [
      [players(:frodo).id, 20],
      [players(:gandalf).id, 154],
      [players(:sam).id, 75],
    ]
    tuples = tuples.sort { |t1, t2| t1[0] - t2[0] }
    expected = tuples.map { |t| t[1] }

    assert_equal expected, get_state.sums_ordered_by_player_id
  end

  test 'ordered_players returns the players ordered by ID asc' do
    state = get_state
    players = state.ordered_players

    assert_equal players.size, 3
    assert_equal players[0].id < players[1].id, true
    assert_equal players[1].id < players[2].id, true
  end

  private

  def get_state
    Scorecards::ShowState.new(
      user: users(:david),
      scorecard_id: scorecards(:hand_and_foot).id,
    )
  end
end
