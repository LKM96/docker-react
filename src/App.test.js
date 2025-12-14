import { render, screen } from '@testing-library/react';
import App from './App';

test('renders changed link text', () => {
  render(<App />);
  const linkElement = screen.getByText(/i was changed/i);
  expect(linkElement).toBeInTheDocument();
});

test('renders changed link text', () => {
  render(<App />);
  const linkElement = screen.getByText(/i was changed/i);
  expect(linkElement).toBeInTheDocument();
});


