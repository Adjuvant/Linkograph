float easeInOutCubic (float currentTime, float startValue, float changeValue, float duration) {
  currentTime /= duration/2.0;
  if (currentTime < 1.0) return changeValue/2.0*currentTime*currentTime*currentTime + startValue;
  currentTime -= 2.0;
  return changeValue/2.0*(currentTime*currentTime*currentTime + 2.0) + startValue;
}