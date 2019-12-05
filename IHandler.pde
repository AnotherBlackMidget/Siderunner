interface IHandler
{
  void handle(int deltaTime);
  boolean setMove(int k, boolean b);
  boolean nextState();
}
