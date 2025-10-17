@if ($proizvodi->hasPages())
    <nav aria-label="Stranice proizvoda">
        <ul class="pagination">
            {{-- Previous Page Link --}}
            @if ($proizvodi->onFirstPage())
                <li class="page-item disabled" aria-disabled="true" aria-label="Prethodna">
                    <span class="page-link" aria-hidden="true">&laquo;</span>
                </li>
            @else
                <li class="page-item">
                    <a class="page-link" href="{{ $proizvodi->previousPageUrl() }}" rel="prev" aria-label="Prethodna">&laquo;</a>
                </li>
            @endif

            {{-- Pagination Elements --}}
            @foreach ($proizvodi->links()->elements[0] ?? [] as $page => $url)
                @if ($page == $proizvodi->currentPage())
                    <li class="page-item active" aria-current="page"><span class="page-link">{{ $page }}</span></li>
                @else
                    <li class="page-item"><a class="page-link" href="{{ $url }}">{{ $page }}</a></li>
                @endif
            @endforeach

            {{-- Next Page Link --}}
            @if ($proizvodi->hasMorePages())
                <li class="page-item">
                    <a class="page-link" href="{{ $proizvodi->nextPageUrl() }}" rel="next" aria-label="Sljedeća">&raquo;</a>
                </li>
            @else
                <li class="page-item disabled" aria-disabled="true" aria-label="Sljedeća">
                    <span class="page-link" aria-hidden="true">&raquo;</span>
                </li>
            @endif
        </ul>
    </nav>
@endif
