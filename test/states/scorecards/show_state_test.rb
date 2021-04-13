require 'test_helper'

class ScoreTest < ActiveSupport::TestCase
  test 'the truth' do
    assert true
  end

  test 'just see what it fetches' do
    state = get_state
    assert_equal state.scorecard.players.size, 3
  end

  test 'sum_by_user_id should add up sums for each user' do
    sum_by_user_id = get_state.sum_by_user_id
    assert_equal sum_by_user_id[players(:frodo).id], 20
    assert_equal sum_by_user_id[players(:gandalf).id], 154
    assert_equal sum_by_user_id[players(:sam).id], 75
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
